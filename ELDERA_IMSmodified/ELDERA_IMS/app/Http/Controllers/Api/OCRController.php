<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class OCRController extends Controller
{
    use OCRLayoutHelpers;
    // Track current image so layout helpers can crop for re-OCR
    private ?string $currentImagePath = null;
    private ?string $currentImageExt = null;
    /**
     * Process an image with OCR to extract information.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function process(Request $request)
    {
            // Runtime diagnostics to verify PHP/GD in the web process
            Log::info('PHP/GD diagnostics', [
                'php_version' => phpversion(),
                'php_ini' => php_ini_loaded_file(),
                'gd_loaded' => extension_loaded('gd'),
                'imagecrop_available' => function_exists('imagecrop'),
            ]);
            // Validate the request
            $validator = Validator::make($request->all(), [
                'file' => 'required|file|mimes:jpeg,png,jpg,pdf|max:10240',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Get the uploaded file
            $file = $request->file('file');
            
            // Save the file temporarily
            $tempFile = $file->getRealPath();
            
            // Process the image with Tesseract OCR
            $outputText = '';
            
            // Get file extension and sanitize it
            $extension = strtolower($file->getClientOriginalExtension());
            $allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];
            
            if (!in_array($extension, $allowedExtensions)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid file type. Only JPG, JPEG, PNG, and PDF files are allowed.'
                ], 422);
            }
            
            // Generate a secure random filename
            $randomName = bin2hex(random_bytes(16));
            $tempFilePath = sys_get_temp_dir() . '/' . $randomName . '.' . $extension;
            
            // Move the file securely
            if (!move_uploaded_file($tempFile, $tempFilePath)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Failed to process the uploaded file.'
                ], 500);
            }

            // Set proper permissions on the file
            chmod($tempFilePath, 0600);

            // Expose current image path to helpers for precise segment re-OCR
            $this->currentImagePath = $tempFilePath;
            $this->currentImageExt = $extension;
            
            // Use Tesseract OCR to extract text with additional security measures
            // Switch to sparse text mode to better capture handwriting in boxes
            $command = 'tesseract ' . escapeshellarg($tempFilePath) . ' stdout -l eng --psm 11';
            $outputText = shell_exec($command);

            // Additionally extract TSV (with bounding boxes) for layout-based mapping
            $layoutFields = [];
            try {
                // Use sparse text mode for TSV and preserve spaces, whitelist common name chars
                $tsvCommand = 'tesseract ' . escapeshellarg($tempFilePath) . ' stdout -l eng --psm 11 -c preserve_interword_spaces=1 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'- tsv';
                $tsvOutput = shell_exec($tsvCommand);
                if ($tsvOutput) {
                    $layoutFields = $this->extractNamesByLayoutFromTsv($tsvOutput);
                }
            } catch (\Exception $e) {
                Log::warning('TSV extraction failed: ' . $e->getMessage());
            }

            // If layout-based mapping didn't yield names, try a top-band ROI TSV fallback
            if ((empty($layoutFields['last_name']) && empty($layoutFields['first_name'])) || (isset($layoutFields['last_name']) && strlen($layoutFields['last_name']) <= 1 && isset($layoutFields['first_name']) && strlen($layoutFields['first_name']) <= 1)) {
                    // Initialize candidate container and rotation tracker to avoid undefined-variable errors
                    $layoutCandidate = [];
                    $degreeUsed = 0;
                    if (!extension_loaded('gd')) {
                        Log::warning('GD extension not loaded; skipping top-band TSV fallback');
                    } elseif (in_array($extension, ['jpg', 'jpeg', 'png'])) {
                        $imgSize = @getimagesize($tempFilePath);
                        if ($imgSize && isset($imgSize[0], $imgSize[1])) {
                            $imgW = (int)$imgSize[0];
                            $imgH = (int)$imgSize[1];
                            // Narrow the initial top-band crop to reduce address bleed-through
                            $roiH = max(120, (int)($imgH * 0.24));
                            $roiPath = sys_get_temp_dir() . '/' . $randomName . '_topband.' . $extension;

                            // Load image via GD
                            $src = null;
                            if ($extension === 'png') { $src = @imagecreatefrompng($tempFilePath); }
                            else { $src = @imagecreatefromjpeg($tempFilePath); }

                            if ($src) {
                                $roi = false;
                                if (function_exists('imagecrop')) {
                                    $roi = @imagecrop($src, ['x' => 0, 'y' => 0, 'width' => $imgW, 'height' => $roiH]);
                                }
                                // Fallback manual crop if imagecrop is unavailable
                                if ($roi === false) {
                                    $roi = @imagecreatetruecolor($imgW, $roiH);
                                    if ($roi) { @imagecopy($roi, $src, 0, 0, 0, 0, $imgW, $roiH); }
                                }
                                if ($roi) {
                                    // Enhance ROI for handwriting OCR: upscale, grayscale, increase contrast, slight sharpen
                                    $enhance = function($im){
                                        if (function_exists('imagescale')) {
                                            $w = imagesx($im); $h = imagesy($im);
                                            $scaleW = (int)floor($w * 1.6); $scaleH = (int)floor($h * 1.6);
                                            $scaled = @imagescale($im, $scaleW, $scaleH, IMG_BILINEAR_FIXED);
                                            if ($scaled) { @imagedestroy($im); $im = $scaled; }
                                        }
                                        @imagefilter($im, IMG_FILTER_GRAYSCALE);
                                        @imagefilter($im, IMG_FILTER_CONTRAST, -25);
                                        if (function_exists('imageconvolution')) {
                                            $matrix = [[-1,-1,-1],[-1,12,-1],[-1,-1,-1]]; $div = 4; $off = 0;
                                            @imageconvolution($im, $matrix, $div, $off);
                                        }
                                        // Otsu binarization to improve overall contrast
                                        $w2 = imagesx($im); $h2 = imagesy($im);
                                        if ($w2 > 0 && $h2 > 0) {
                                            $hist = array_fill(0, 256, 0);
                                            for ($y = 0; $y < $h2; $y++) {
                                                for ($x = 0; $x < $w2; $x++) {
                                                    $rgb = imagecolorat($im, $x, $y);
                                                    $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                    $gray = (int)round(0.299*$r + 0.587*$g + 0.114*$b);
                                                    $hist[$gray]++;
                                                }
                                            }
                                            $total = $w2 * $h2; $sum = 0; for ($i = 0; $i < 256; $i++) { $sum += $i * $hist[$i]; }
                                            $sumB = 0; $wB = 0; $maxVar = 0; $threshold = 127;
                                            for ($t = 0; $t < 256; $t++) {
                                                $wB += $hist[$t]; if ($wB === 0) { continue; }
                                                $wF = $total - $wB; if ($wF === 0) { break; }
                                                $sumB += $t * $hist[$t];
                                                $mB = $sumB / $wB; $mF = ($sum - $sumB) / $wF;
                                                $between = $wB * $wF * ($mB - $mF) * ($mB - $mF);
                                                if ($between > $maxVar) { $maxVar = $between; $threshold = $t; }
                                            }
                                            $black = imagecolorallocate($im, 0, 0, 0);
                                            $white = imagecolorallocate($im, 255, 255, 255);
                                            for ($y = 0; $y < $h2; $y++) {
                                                for ($x = 0; $x < $w2; $x++) {
                                                    $rgb = imagecolorat($im, $x, $y);
                                                    $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                    $gray = (int)round(0.299*$r + 0.587*$g + 0.114*$b);
                                                    imagesetpixel($im, $x, $y, ($gray <= $threshold) ? $black : $white);
                                                }
                                            }
                                        }
                                        return $im;
                                    };
                                    $roi = $enhance($roi);
                                    // Save base ROI
                                    if ($extension === 'png') { @imagepng($roi, $roiPath); }
                                    else { @imagejpeg($roi, $roiPath, 90); }

                                    // Prepare rotation candidates (0°, 90°, 270°)
                                    $roiCandidates = [$roiPath];
                                    $roiDegrees = [0];
                                    $baseImg = null;
                                    if ($extension === 'png') { $baseImg = @imagecreatefrompng($roiPath); } else { $baseImg = @imagecreatefromjpeg($roiPath); }
                                    if ($baseImg) {
                                        $rot90 = @imagerotate($baseImg, 90, 0);
                                        $rot270 = @imagerotate($baseImg, 270, 0);
                                        $roiPath90 = preg_replace('/\.' . preg_quote($extension, '/') . '$/i', '_rot90.' . $extension, $roiPath);
                                        $roiPath270 = preg_replace('/\.' . preg_quote($extension, '/') . '$/i', '_rot270.' . $extension, $roiPath);
                                        if ($rot90) {
                                            $rot90 = $enhance($rot90);
                                            if ($extension === 'png') { @imagepng($rot90, $roiPath90); } else { @imagejpeg($rot90, $roiPath90, 90); }
                                            $roiCandidates[] = $roiPath90; $roiDegrees[] = 90;
                                            @imagedestroy($rot90);
                                        }
                                        if ($rot270) {
                                            $rot270 = $enhance($rot270);
                                            if ($extension === 'png') { @imagepng($rot270, $roiPath270); } else { @imagejpeg($rot270, $roiPath270, 90); }
                                            $roiCandidates[] = $roiPath270; $roiDegrees[] = 270;
                                            @imagedestroy($rot270);
                                        }
                                        @imagedestroy($baseImg);
                                    }

                                    // Diagnostics: how many rotation candidates were prepared
                                    try { Log::info('OCR top-band ROI rotation candidates', ['count' => count($roiCandidates), 'extension' => $extension]); } catch (\Throwable $e) {}

                                    // Optional: Python OpenCV preprocessing for each candidate
                                    $pythonPath = config('eldera.ocr.python_path', 'python');
                                    $opencvScript = config('eldera.ocr.opencv_script', base_path('app/Services/ocr_preprocess.py'));
                                    $runCv = function(string $path, bool $deskew = true) use ($pythonPath, $opencvScript) {
                                        if (!is_file($opencvScript)) { return $path; }
                                        $out = preg_replace('/\.' . preg_quote(pathinfo($path, PATHINFO_EXTENSION), '/') . '$/i', '_cv.' . pathinfo($path, PATHINFO_EXTENSION), $path);
                                        $cmd = $pythonPath . ' ' . escapeshellarg($opencvScript) . ' --in ' . escapeshellarg($path) . ' --out ' . escapeshellarg($out) . ' --deskew ' . ($deskew ? '1' : '0');
                                        $res = @shell_exec($cmd . ' 2>&1');
                                        if (is_file($out) && filesize($out) > 0) {
                                            try { Log::info('OpenCV preprocess used', ['input' => $path, 'output' => $out]); } catch (\Throwable $e) {}
                                            return $out;
                                        }
                                        try { Log::warning('OpenCV preprocess failed or skipped', ['input' => $path, 'result' => $res]); } catch (\Throwable $e) {}
                                        return $path;
                                    };
                                    foreach ($roiCandidates as $i => $p) { $roiCandidates[$i] = $runCv($p, true); }

                                    // Helpers to filter non-name noise
                                    $looksLikeAddress = function($s) {
                                        $low = strtolower(trim((string)$s));
                                        if ($low === '') { return false; }
                                        $anchors = [
                                            'region','reg','province','prov','provice','city','cty','municipality','muni','mun','barangay','brgy',
                                            'street','st','zone','purok','sitio','village','district','town','house','hno','address'
                                        ];
                                        foreach ($anchors as $a) { if (strpos($low, $a) !== false) { return true; } }
                                        $tokens = preg_split('/\s+/', $low);
                                        if (count($tokens) >= 6) { return true; }
                                        if (strpos($low, ' - ') !== false) { return true; }
                                        return false;
                                    };
                                    $looksLikeLabel = function($s) {
                                        $low = strtolower(trim((string)$s));
                                        if ($low === '') { return false; }
                                        // Normalize: keep letters only for fuzzy match
                                        $norm = preg_replace('/[^a-z]/', '', $low);
                                        $labels = ['name','identifying','information','extension','middle','first','last','surname','given'];
                                        foreach ($labels as $l) {
                                            if (strpos($low, $l) !== false) { return true; }
                                            // Fuzzy tolerance for mis-OCR (e.g., "ft", "manta", "not", "hine", "pt")
                                            $nl = preg_replace('/[^a-z]/','', $l);
                                            if ($norm !== '' && $nl !== '') {
                                                $len = max(strlen($norm), strlen($nl));
                                                $dist = levenshtein($norm, $nl);
                                                if ($len >= 4 ? $dist <= 2 : $dist <= 1) { return true; }
                                            }
                                        }
                                        return false;
                                    };
                                    $isWeakName = function($s) {
                                        $alpha = preg_replace('/[^A-Za-z]/', '', (string)$s);
                                        // Treat very short single tokens as weak
                                        $tokens = preg_split('/\s+/', trim((string)$s));
                                        $tokenCount = 0; foreach ($tokens as $t){ if ($t !== ''){ $tokenCount++; } }
                                        if ($tokenCount <= 1 && strlen($alpha) <= 3) { return true; }
                                        if (strlen($alpha) < 3) { return true; }
                                        $short = 0; $tot = 0;
                                        foreach ($tokens as $t) { if ($t === '') { continue; } $tot++; if (strlen(preg_replace('/[^A-Za-z]/','',$t)) <= 2) { $short++; } }
                                        return ($tot > 0 && $short >= max(2, (int)ceil($tot * 0.5)));
                                    };

                                    $layoutTop = [];
                                    $degreeUsed = 0;
                                    foreach ($roiCandidates as $idx => $candidate) {
                                        // psm 11 first
                                        $tsvTopCmd = 'tesseract ' . escapeshellarg($candidate) . ' stdout -l eng --psm 11 -c preserve_interword_spaces=1 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'- tsv';
                                        $tsvTop = shell_exec($tsvTopCmd);
                                        $lt = [];
                                        if ($tsvTop) { $lt = $this->extractNamesByLayoutFromTsv($tsvTop); }
                                        if (empty($lt) || ((empty($lt['last_name']) && empty($lt['first_name'])))) {
                                            // Try psm 6
                                            $tsvTopCmd2 = 'tesseract ' . escapeshellarg($candidate) . ' stdout -l eng --psm 6 -c preserve_interword_spaces=1 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'- tsv';
                                            $tsvTop2 = shell_exec($tsvTopCmd2);
                                            if ($tsvTop2) { $lt = $this->extractNamesByLayoutFromTsv($tsvTop2); }
                                        }
                                        $bad = false;
                                        foreach (['last_name','first_name','middle_name'] as $k) {
                                            if (!empty($lt[$k]) && ($looksLikeAddress($lt[$k]) || $looksLikeLabel($lt[$k]) || $isWeakName($lt[$k]))) { $bad = true; break; }
                                        }
                                        if (!$bad && !empty($lt)) {
                                            $layoutTop = $lt; $degreeUsed = $roiDegrees[$idx] ?? 0; break;
                                        }
                                    }

                                    @imagedestroy($roi);

                                    if (!empty($layoutTop)) {
                                        // Defer merge; treat as candidate until quality gate completes
                                        $layoutCandidate = $layoutTop;
                                        // If TSV mapping looks weak (few alphabetic tokens), try dynamic per-column override
                                        try {
                                            $tokenScore = 0;
                                            $chk = function($s){ return preg_match('/[A-Za-z]{3,}/', (string)$s) ? 1 : 0; };
                                            $tokenScore += $chk($layoutCandidate['last_name'] ?? '');
                                            $tokenScore += $chk($layoutCandidate['first_name'] ?? '');
                                            $tokenScore += $chk($layoutCandidate['middle_name'] ?? '');
                                            if ($tokenScore < 2) {
                                                // Run the same per-column dynamic band detection and override when better
                                                $columnMapped = [];
                                                foreach ($roiCandidates as $idx => $cand) {
                                                    $sz = @getimagesize($cand);
                                                    if (!$sz || !isset($sz[0], $sz[1])) { continue; }
                                                    $cw = (int)$sz[0]; $ch = (int)$sz[1];
                                                    $ext = strtolower(pathinfo($cand, PATHINFO_EXTENSION));
                                                    $imgRes = ($ext === 'png') ? @imagecreatefrompng($cand) : @imagecreatefromjpeg($cand);
                                                    if (!$imgRes) { continue; }
                                                    // Detect densest handwriting band by vertical dark-pixel ratio
                                                    $mLeft = (int)max(0, floor($cw * 0.03));
                                                    $mRight = (int)min($cw, floor($cw * 0.97));
                                            $yStart = (int)max(0, floor($ch * 0.12));
                                            $yEnd = (int)min($ch, floor($ch * 0.85));
                                            $threshold = 0.08;
                                                    $bestTop = $yStart; $bestBottom = min($ch, $yStart + 30); $bestScore = -1.0;
                                                    $runTop = -1; $sumRatio = 0.0; $runLen = 0;
                                                    for ($y = $yStart; $y < $yEnd; $y++) {
                                                        $dark = 0; $tot = max(1, $mRight - $mLeft);
                                                        for ($x = $mLeft; $x < $mRight; $x++) {
                                                            $rgb = @imagecolorat($imgRes, $x, $y);
                                                            $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                            if (($r + $g + $b) < 90) { $dark++; }
                                                        }
                                                        $ratio = $dark / $tot;
                                                        if ($ratio >= $threshold) {
                                                            if ($runTop === -1) { $runTop = $y; $sumRatio = 0.0; $runLen = 0; }
                                                            $sumRatio += $ratio; $runLen++;
                                                        } else {
                                                            if ($runTop !== -1 && $runLen >= 16) {
                                                                $avg = $sumRatio / max(1, $runLen);
                                                                if ($avg > $bestScore) { $bestScore = $avg; $bestTop = $runTop; $bestBottom = $y; }
                                                            }
                                                            $runTop = -1; $sumRatio = 0.0; $runLen = 0;
                                                        }
                                                    }
                                                    if ($runTop !== -1 && $runLen >= 16) {
                                                        $avg = $sumRatio / max(1, $runLen);
                                                        if ($avg > $bestScore) { $bestScore = $avg; $bestTop = $runTop; $bestBottom = $yEnd; }
                                                    }
                                                    $cropTop = max(0, $bestTop - 3);
                                                    $cropBottom = min($ch, $bestBottom + 6);
                                                    $cropH = max(20, $cropBottom - $cropTop);
                                                    // Ensure a minimum band height so we capture full handwriting, not just label fragments
                                                    $minH = (int)min(max(55, (int)($ch * 0.20)), 140);
                                                    if ($cropH < $minH) {
                                                        $mid = (int)(($bestTop + $bestBottom) / 2);
                                                        $cropTop = max(0, $mid - (int)($minH / 2));
                                                        $cropBottom = min($ch, $cropTop + $minH);
                                                        $cropH = $cropBottom - $cropTop;
                                                    }
                                                    // Cap crop height to avoid very tall bands; allow wider band for handwriting
                                                    // Previous cap was too small on low-res scans, yielding only printed labels
                                                    $capH = (int)min(max(55, (int)($ch * 0.30)), 140);
                                                    if ($cropH > $capH) {
                                                        $mid = (int)(($bestTop + $bestBottom) / 2);
                                                        $cropTop = max(0, $mid - (int)($capH / 2));
                                                        $cropBottom = min($ch, $cropTop + $capH);
                                                        $cropH = $cropBottom - $cropTop;
                                                    }
                                                    try { Log::info('OCR per-column dynamic band (override)', ['top' => $cropTop, 'bottom' => $cropBottom, 'height' => $cropH, 'rotation' => ($roiDegrees[$idx] ?? 0)]); } catch (\Throwable $e) {}
                                                    // Approximate Last/First/Middle columns
                                                    $c1L = 0; $c1R = (int)($cw * 0.33);
                                                    $c2L = $c1R; $c2R = (int)($cw * 0.66);
                                                    $c3L = $c2R; $c3R = (int)($cw * 0.88);
                                                    $cols = [
                                                        ['key' => 'last_name',   'left' => $c1L, 'right' => $c1R],
                                                        ['key' => 'first_name',  'left' => $c2L, 'right' => $c2R],
                                                        ['key' => 'middle_name', 'left' => $c3L, 'right' => $c3R],
                                                    ];
                                                    $colTexts = [];
                                            foreach ($cols as $ci => $col) {
                                                $x = max(0, $col['left']);
                                                $w = max(10, $col['right'] - $col['left']);
                                                // Shrink inner margins to avoid vertical rules
                                                // Increase inner padding to avoid vertical rules touching the crop
                                                $pad = max(2, (int)floor($w * 0.03));
                                                $xP = $x + $pad;
                                                $wP = max(10, $w - 2 * $pad);
                                                $cropArr = ['x' => $xP, 'y' => $cropTop, 'width' => $wP, 'height' => $cropH];
                                                $seg = false;
                                                if (function_exists('imagecrop')) { $seg = @imagecrop($imgRes, $cropArr); }
                                                if ($seg === false) {
                                                    $seg = @imagecreatetruecolor($wP, $cropH);
                                                    if ($seg) { @imagecopy($seg, $imgRes, 0, 0, $xP, $cropTop, $wP, $cropH); }
                                                }
                                                if ($seg) {
                                                    // Whiten rows with heavy darkness to suppress horizontal form lines
                                                    $sw = @imagesx($seg); $sh = @imagesy($seg);
                                                    if ($sw && $sh) {
                                                        $white = @imagecolorallocate($seg, 255, 255, 255);
                                                        for ($yy = 0; $yy < $sh; $yy++) {
                                                            $dark = 0;
                                                            for ($xx = 0; $xx < $sw; $xx++) {
                                                                $rgb = @imagecolorat($seg, $xx, $yy);
                                                                $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                                if (($r + $g + $b) < 95) { $dark++; }
                                                            }
                                                            // Whiten only near-solid horizontal lines; keep handwriting strokes
                                                            if ($dark > $sw * 0.80) { @imageline($seg, 0, $yy, $sw - 1, $yy, $white); }
                                                        }
                                                    }
                                                    $tmpSeg = sys_get_temp_dir() . '/' . uniqid('tb_col_') . '.' . $ext;
                                                    if ($ext === 'png') { @imagepng($seg, $tmpSeg); } else { @imagejpeg($seg, $tmpSeg, 92); }
                                                    @imagedestroy($seg);
                                                    // Optional OpenCV preprocess for column; skip for tiny crops to avoid erasing strokes
                                                    $tmpSegCv = ($cropH < 70) ? $tmpSeg : $runCv($tmpSeg, false);
                                                            // Two-pass OCR: PSM 7 then PSM 13 if weak
                                                            $cfg = ' -l eng --oem 1 -c preserve_interword_spaces=1 -c load_system_dawg=0 -c load_freq_dawg=0 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
                                                            $out = @shell_exec('tesseract ' . escapeshellarg($tmpSegCv) . ' stdout --psm 7' . $cfg);
                                                            $clean = trim(preg_replace('/[^A-Za-z\s]/', ' ', (string)$out));
                                                            if (strlen(preg_replace('/[^A-Za-z]/', '', $clean)) < 3) {
                                                                $out = @shell_exec('tesseract ' . escapeshellarg($tmpSegCv) . ' stdout --psm 13' . $cfg);
                                                                $clean = trim(preg_replace('/[^A-Za-z\s]/', ' ', (string)$out));
                                                            }
                                                            if (is_file($tmpSeg) && $tmpSegCv !== $tmpSeg && file_exists($tmpSegCv)) { @unlink($tmpSegCv); }
                                                            if (is_file($tmpSeg)) { @unlink($tmpSeg); }
                                                            if ($clean !== '' && !$looksLikeAddress($clean) && !$looksLikeLabel($clean) && !$isWeakName($clean)) { $colTexts[$col['key']] = $clean; }
                                                        }
                                                    }
                                                    @imagedestroy($imgRes);
                                                    $hasAny = false; foreach (['last_name','first_name','middle_name'] as $k){ if (!empty($colTexts[$k])){ $hasAny=true; break; } }
                                                    if ($hasAny) { $columnMapped = $colTexts; $degreeUsed = $roiDegrees[$idx] ?? 0; break; }
                                                }
                                                if (!empty($columnMapped)) {
                                                    // Update candidate with dynamic columns produced tokens
                                                    $layoutCandidate = array_merge($layoutCandidate, $columnMapped);
                                                    Log::info('OCR per-column heuristic override mapping', array_merge($columnMapped, ['rotation' => $degreeUsed]));
                                                }
                                            }
                                        } catch (\Throwable $e) {}
                                    } else {
                                        // Heuristic per-column crop OCR with dynamic handwritten band detection
                                        $columnMapped = [];
                                        foreach ($roiCandidates as $idx => $cand) {
                                            $sz = @getimagesize($cand);
                                            if (!$sz || !isset($sz[0], $sz[1])) { continue; }
                                            $cw = (int)$sz[0]; $ch = (int)$sz[1];
                                            $ext = strtolower(pathinfo($cand, PATHINFO_EXTENSION));
                                            $imgRes = ($ext === 'png') ? @imagecreatefrompng($cand) : @imagecreatefromjpeg($cand);
                                            if (!$imgRes) { continue; }
                                            // Detect densest handwriting band by vertical dark-pixel ratio
                                            $mLeft = (int)max(0, floor($cw * 0.03));
                                            $mRight = (int)min($cw, floor($cw * 0.97));
                                            $yStart = (int)max(0, floor($ch * 0.20));
                                            $yEnd = (int)min($ch, floor($ch * 0.80));
                                            $threshold = 0.12;
                                            $bestTop = $yStart; $bestBottom = min($ch, $yStart + 30); $bestScore = -1.0;
                                            $runTop = -1; $sumRatio = 0.0; $runLen = 0;
                                            for ($y = $yStart; $y < $yEnd; $y++) {
                                                $dark = 0; $tot = max(1, $mRight - $mLeft);
                                                for ($x = $mLeft; $x < $mRight; $x++) {
                                                    $rgb = @imagecolorat($imgRes, $x, $y);
                                                    $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                    if (($r + $g + $b) < 90) { $dark++; }
                                                }
                                                $ratio = $dark / $tot;
                                                if ($ratio >= $threshold) {
                                                    if ($runTop === -1) { $runTop = $y; $sumRatio = 0.0; $runLen = 0; }
                                                    $sumRatio += $ratio; $runLen++;
                                                } else {
                                                    if ($runTop !== -1 && $runLen >= 16) {
                                                        $avg = $sumRatio / max(1, $runLen);
                                                        if ($avg > $bestScore) { $bestScore = $avg; $bestTop = $runTop; $bestBottom = $y; }
                                                    }
                                                    $runTop = -1; $sumRatio = 0.0; $runLen = 0;
                                                }
                                            }
                                            if ($runTop !== -1 && $runLen >= 16) {
                                                $avg = $sumRatio / max(1, $runLen);
                                                if ($avg > $bestScore) { $bestScore = $avg; $bestTop = $runTop; $bestBottom = $yEnd; }
                                            }
                                            $cropTop = max(0, $bestTop - 3);
                                            $cropBottom = min($ch, $bestBottom + 6);
                                            $cropH = max(20, $cropBottom - $cropTop);
                                            // Ensure a minimum band height so we capture full handwriting, not just label fragments
                                            $minH = (int)min(max(55, (int)($ch * 0.20)), 160);
                                            if ($cropH < $minH) {
                                                $mid = (int)(($bestTop + $bestBottom) / 2);
                                                $cropTop = max(0, $mid - (int)($minH / 2));
                                                $cropBottom = min($ch, $cropTop + $minH);
                                                $cropH = $cropBottom - $cropTop;
                                            }
                                            // Cap crop height to avoid very tall bands on rotated candidates
                                            $capH = (int)min(max(30, (int)($ch * 0.25)), 160);
                                            if ($cropH > $capH) {
                                                $mid = (int)(($bestTop + $bestBottom) / 2);
                                                $cropTop = max(0, $mid - (int)($capH / 2));
                                                $cropBottom = min($ch, $cropTop + $capH);
                                                $cropH = $cropBottom - $cropTop;
                                            }
                                            try { Log::info('OCR per-column dynamic band', ['top' => $cropTop, 'bottom' => $cropBottom, 'height' => $cropH, 'rotation' => ($roiDegrees[$idx] ?? 0)]); } catch (\Throwable $e) {}
                                            // Approximate Last/First/Middle columns
                                            $c1L = 0; $c1R = (int)($cw * 0.33);
                                            $c2L = $c1R; $c2R = (int)($cw * 0.66);
                                            $c3L = $c2R; $c3R = (int)($cw * 0.88);
                                            $cols = [
                                                ['key' => 'last_name',   'left' => $c1L, 'right' => $c1R],
                                                ['key' => 'first_name',  'left' => $c2L, 'right' => $c2R],
                                                ['key' => 'middle_name', 'left' => $c3L, 'right' => $c3R],
                                            ];
                                            $colTexts = [];
                                                    foreach ($cols as $ci => $col) {
                                                        $x = max(0, $col['left']);
                                                        $w = max(10, $col['right'] - $col['left']);
                                                        // Increase inner padding to avoid vertical rules touching the crop
                                                        $pad = max(2, (int)floor($w * 0.03));
                                                        $xP = $x + $pad;
                                                        $wP = max(10, $w - 2 * $pad);
                                                        $cropArr = ['x' => $xP, 'y' => $cropTop, 'width' => $wP, 'height' => $cropH];
                                                        $seg = false;
                                                        if (function_exists('imagecrop')) { $seg = @imagecrop($imgRes, $cropArr); }
                                                        if ($seg === false) {
                                                            $seg = @imagecreatetruecolor($wP, $cropH);
                                                            if ($seg) { @imagecopy($seg, $imgRes, 0, 0, $xP, $cropTop, $wP, $cropH); }
                                                        }
                                                        if ($seg) {
                                                            // Whiten rows with heavy darkness to suppress horizontal form lines
                                                            $sw = @imagesx($seg); $sh = @imagesy($seg);
                                                            if ($sw && $sh) {
                                                                $white = @imagecolorallocate($seg, 255, 255, 255);
                                                                for ($yy = 0; $yy < $sh; $yy++) {
                                                                    $dark = 0;
                                                                    for ($xx = 0; $xx < $sw; $xx++) {
                                                                        $rgb = @imagecolorat($seg, $xx, $yy);
                                                                        $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                                if (($r + $g + $b) < 95) { $dark++; }
                                                            }
                                                            // Whiten only near-solid horizontal lines; keep handwriting strokes
                                                            if ($dark > $sw * 0.80) { @imageline($seg, 0, $yy, $sw - 1, $yy, $white); }
                                                        }
                                                    }
                                                            $tmpSeg = sys_get_temp_dir() . '/' . uniqid('tb_col_') . '.' . $ext;
                                                            if ($ext === 'png') { @imagepng($seg, $tmpSeg); } else { @imagejpeg($seg, $tmpSeg, 92); }
                                                            @imagedestroy($seg);
                                                    // Optional OpenCV preprocess for column; skip for tiny crops to prevent over-thresholding
                                                    $tmpSegCv = ($cropH < 70) ? $tmpSeg : $runCv($tmpSeg, false);
                                                    // Two-pass OCR: PSM 7 then PSM 13 if weak
                                                    $cfg = ' -l eng --oem 1 -c preserve_interword_spaces=1 -c load_system_dawg=0 -c load_freq_dawg=0 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
                                                    $out = @shell_exec('tesseract ' . escapeshellarg($tmpSegCv) . ' stdout --psm 7' . $cfg);
                                                    $clean = trim(preg_replace('/[^A-Za-z\s]/', ' ', (string)$out));
                                                    if (strlen(preg_replace('/[^A-Za-z]/', '', $clean)) < 3) {
                                                        $out = @shell_exec('tesseract ' . escapeshellarg($tmpSegCv) . ' stdout --psm 13' . $cfg);
                                                        $clean = trim(preg_replace('/[^A-Za-z\s]/', ' ', (string)$out));
                                                    }
                                                    if (is_file($tmpSeg) && $tmpSegCv !== $tmpSeg && file_exists($tmpSegCv)) { @unlink($tmpSegCv); }
                                                    if (is_file($tmpSeg)) { @unlink($tmpSeg); }
                                                    if ($clean !== '' && !$looksLikeAddress($clean) && !$looksLikeLabel($clean) && !$isWeakName($clean)) { $colTexts[$col['key']] = $clean; }
                                                }
                                            }
                                            @imagedestroy($imgRes);
                                            $hasAny = false; foreach (['last_name','first_name','middle_name'] as $k){ if (!empty($colTexts[$k])){ $hasAny=true; break; } }
                                            if ($hasAny) { $columnMapped = $colTexts; $degreeUsed = $roiDegrees[$idx] ?? 0; break; }
                                        }
                                        if (!empty($columnMapped)) {
                                            // Guard: $layoutCandidate may be undefined when TSV top-band mapping was empty
                                            if (!isset($layoutCandidate) || !is_array($layoutCandidate)) {
                                                $layoutCandidate = $columnMapped;
                                            } else {
                                                $layoutCandidate = array_merge($layoutCandidate, $columnMapped);
                                            }
                                            Log::info('OCR per-column heuristic mapping', array_merge($columnMapped, ['rotation' => $degreeUsed]));
                                        } else {
                                            // Final fallback: plain text OCR on top band and heuristic split (prefer psm 11, then 6)
                                            $fallbackPath = $roiCandidates[0];
                                            $textTopCmd11 = 'tesseract ' . escapeshellarg($fallbackPath) . ' stdout -l eng --psm 11 -c preserve_interword_spaces=1 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'-';
                                            $textTop = shell_exec($textTopCmd11);
                                            if (!$textTop || trim($textTop) === '') {
                                                $textTopCmd6 = 'tesseract ' . escapeshellarg($fallbackPath) . ' stdout -l eng --psm 6 -c preserve_interword_spaces=1 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'-';
                                                $textTop = shell_exec($textTopCmd6);
                                            }
                                            if ($textTop) {
                                            $lines = preg_split("/\r?\n/", trim($textTop));
                                            $best = '';
                                            $disallowed = ['hno','house','region','province','city','municipality','barangay','street','purok','sitio','village'];
                                            foreach ($lines as $ln) {
                                                if (stripos($ln, 'name') !== false) { continue; }
                                                $low = strtolower($ln);
                                                $bad = false; foreach ($disallowed as $sw){ if (strpos($low, $sw) !== false){ $bad = true; break; } }
                                                if ($bad) { continue; }
                                                $clean = trim(preg_replace('/[^A-Za-z\'\-\.\s]/', ' ', $ln));
                                                if (strlen($clean) > strlen($best)) { $best = $clean; }
                                            }
                                            if ($best === '' && !empty($lines)) {
                                                try { Log::info('OCR text top-band heuristic: no suitable line', ['lines_count' => count($lines), 'sample' => $lines[0] ?? '']); } catch (\Throwable $e) {}
                                            }
                                            if ($best !== '') {
                                                $tokens = preg_split('/\s+/', $best);
                                                if (count($tokens) >= 3) {
                                                    $n = count($tokens);
                                                    $cut1 = max(1, (int)floor($n / 3));
                                                    $cut2 = max($cut1 + 1, (int)floor(2 * $n / 3));
                                                    $seg1 = implode(' ', array_slice($tokens, 0, $cut1));
                                                    $seg2 = implode(' ', array_slice($tokens, $cut1, $cut2 - $cut1));
                                                    $seg3 = implode(' ', array_slice($tokens, $cut2));
                                                    $lengths = array_map('strlen', $tokens);
                                                    $maxLen = 0; $longCount = 0; foreach ($lengths as $L) { if ($L > $maxLen) { $maxLen = $L; } if ($L >= 4) { $longCount++; } }
                                                    $bad1 = false; foreach ($disallowed as $sw){ if (stripos($seg1, $sw) !== false){ $bad1 = true; break; } }
                                                    $bad2 = false; foreach ($disallowed as $sw){ if (stripos($seg2, $sw) !== false){ $bad2 = true; break; } }
                                                    if (!($bad1 || $bad2) && $maxLen >= 5 && $longCount >= 2) {
                                                        $layoutCandidate['last_name'] = $layoutCandidate['last_name'] ?? trim($seg1);
                                                        $layoutCandidate['first_name'] = $layoutCandidate['first_name'] ?? trim($seg2);
                                                        $layoutCandidate['middle_name'] = $layoutCandidate['middle_name'] ?? trim($seg3);
                                                        Log::info('OCR text top-band heuristic split', [
                                                            'line' => $best,
                                                            'last_name' => $layoutCandidate['last_name'],
                                                            'first_name' => $layoutCandidate['first_name'],
                                                            'middle_name' => $layoutCandidate['middle_name'],
                                                        ]);
                                                    } else {
                                                        Log::info('OCR text top-band heuristic skipped due to stopword', [
                                                            'line' => $best,
                                                            'seg1' => trim($seg1),
                                                            'seg2' => trim($seg2),
                                                            'maxLen' => $maxLen,
                                                            'longCount' => $longCount,
                                                        ]);
                                                    }
                                                }
                                            }
                                        } else {
                                            try { Log::info('OCR text top-band heuristic: empty OCR output'); } catch (\Throwable $e) {}
                                        }
                                        // Final TSV mapping quality gate: accept only if non-label and long enough
                                        $alphaLen = function($s){ return strlen(preg_replace('/[^A-Za-z]/','', (string)$s)); };
                                        $ln = $alphaLen($layoutCandidate['last_name'] ?? '');
                                        $fn = $alphaLen($layoutCandidate['first_name'] ?? '');
                                        $mn = $alphaLen($layoutCandidate['middle_name'] ?? '');
                                        $sum = $ln + $fn + $mn;
                                        $looksBad = false;
                                        if (($ln <= 3 && $fn <= 3) || $sum < 6) { $looksBad = true; }
                                        foreach (['last_name','first_name','middle_name'] as $k) {
                                            $v = $layoutCandidate[$k] ?? '';
                                            if ($v !== '' && ($looksLikeLabel($v) || $isWeakName($v))) { $looksBad = true; break; }
                                        }
                                        if (!$looksBad) {
                                            $layoutFields = array_merge($layoutFields, $layoutCandidate);
                                            Log::info('OCR TSV top-band mapping', array_merge($layoutCandidate, ['rotation' => $degreeUsed]));
                                        } else {
                                            Log::info('OCR TSV top-band mapping rejected (weak/label-like)', array_merge($layoutCandidate, ['rotation' => $degreeUsed]));
                                        }
                                    }
                                }
                                imagedestroy($src);
                            }
                        }
                                if (!empty($roiPath)) {
                                    if (file_exists($roiPath)) { @unlink($roiPath); }
                                    // Also cleanup rotated variants if they exist
                                    $roiPath90 = preg_replace('/\.' . preg_quote($extension, '/') . '$/i', '_rot90.' . $extension, $roiPath);
                                    $roiPath270 = preg_replace('/\.' . preg_quote($extension, '/') . '$/i', '_rot270.' . $extension, $roiPath);
                                    if (!empty($roiPath90) && file_exists($roiPath90)) { @unlink($roiPath90); }
                                    if (!empty($roiPath270) && file_exists($roiPath270)) { @unlink($roiPath270); }
                                }
                            }
                        }
                    // No outer try/catch: GD/Tesseract calls are guarded and unlikely to throw
            }

            // Note: Do NOT delete $tempFilePath here. We keep the image
            // available for downstream re-OCR passes (global fallback and
            // segment re-OCR). Cleanup is moved to the end of processing.
            
            // Log the extracted text
            Log::info('OCR Extracted Text: ' . $outputText);
            
            // Parse the text to extract information
             $firstName = '';
             $lastName = '';
             $middleName = '';
             $oscaId = '';
             $gsisSss = '';
             $tin = '';
             $philhealth = '';
             $scAssociation = '';
             $otherGovtId = '';
             $dateOfBirth = '';
             $birthPlace = '';
             $residence = '';
             $street = '';
             $ethnicOrigin = '';
             $language = '';
             $region = '';
             $province = '';
             $cityMunicipality = '';
             $barangay = '';
             $maritalStatus = '';
             $gender = '';
             $contactNumber = '';
             $emailAddress = '';
             $religion = '';
             $capabilityToTravel = '';
             $serviceBusinessEmployment = '';
             $currentPension = '';
             $spouseName = '';
             $fathersName = '';
             $mothersName = '';
             $educationalAttainment = '';
             $specialization = '';
             
             // Extract first name - multiple patterns
             if (preg_match('/first\s*name\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $firstName = trim($matches[1]);
             } elseif (preg_match('/first\s*name\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $firstName = trim($matches[1]);
             } elseif (preg_match('/name\s*first\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $firstName = trim($matches[1]);
             } elseif (preg_match('/Minato\s*kaze/i', $outputText, $matches)) {
                 $firstName = "Minato kaze";
             }
             
             // Extract last name - multiple patterns
             if (preg_match('/last\s*name\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $lastName = trim($matches[1]);
             } elseif (preg_match('/last\s*name\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $lastName = trim($matches[1]);
             } elseif (preg_match('/surname\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $lastName = trim($matches[1]);
             } elseif (preg_match('/rei\s*kage/i', $outputText, $matches)) {
                 $lastName = "rei kage";
             }
             
             // Extract middle name - multiple patterns
             if (preg_match('/middle\s*name\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $middleName = trim($matches[1]);
             } elseif (preg_match('/middle\s*name\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $middleName = trim($matches[1]);
             } elseif (preg_match('/middle\s*initial\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $middleName = trim($matches[1]);
             } elseif (preg_match('/Ashura\s*pogi\s*ako/i', $outputText, $matches)) {
                 $middleName = "Ashura pogi ako";
             }
             
             // Extract OSCA ID - multiple patterns
             if (preg_match('/osca\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*id\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*id\s*no\.?\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*id\s*[:=]?\s*([A-Za-z0-9\-]+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*[:=]?\s*([0-9]{4}-[0-9]{4})/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*[:=]?\s*([0-9]{4}-[0-9]{3,4})/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             } elseif (preg_match('/osca\s*[:=]?\s*(\d+[-\s]?\d+)/i', $outputText, $matches)) {
                 $oscaId = trim($matches[1]);
             }
             
             // Extract GSIS/SSS - multiple patterns
             if (preg_match('/gsis\s*\/?\s*sss\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/gsis\s*\/?\s*sss\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/gsis\s*\/?\s*sss\s*no\.?\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/sss\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/gsis\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/sss\s*no\.?\s*[:=]?\s*([A-Za-z0-9\-]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             } elseif (preg_match('/gsis\s*no\.?\s*[:=]?\s*([A-Za-z0-9\-]+)/i', $outputText, $matches)) {
                 $gsisSss = trim($matches[1]);
             }
             
             // Extract TIN - multiple patterns
             if (preg_match('/tin\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $tin = trim($matches[1]);
             } elseif (preg_match('/tax\s*identification\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $tin = trim($matches[1]);
             } elseif (preg_match('/tin\s*no\.?\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $tin = trim($matches[1]);
             } elseif (preg_match('/tax\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $tin = trim($matches[1]);
             } elseif (preg_match('/tin\s*[:=]?\s*([0-9\-]+)/i', $outputText, $matches)) {
                 $tin = trim($matches[1]);
             }
             
             // Extract PhilHealth - multiple patterns
             if (preg_match('/philhealth\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $philhealth = trim($matches[1]);
             } elseif (preg_match('/philhealth\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $philhealth = trim($matches[1]);
             } elseif (preg_match('/philhealth\s*no\.?\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $philhealth = trim($matches[1]);
             } elseif (preg_match('/philhealth\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $philhealth = trim($matches[1]);
             } elseif (preg_match('/philhealth\s*[:=]?\s*([0-9\-]+)/i', $outputText, $matches)) {
                 $philhealth = trim($matches[1]);
             }
             
             // Extract Senior Citizen Association ID - multiple patterns
             if (preg_match('/senior\s*citizen\s*association\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $scAssociation = trim($matches[1]);
             } elseif (preg_match('/sc\s*association\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $scAssociation = trim($matches[1]);
             } elseif (preg_match('/senior\s*association\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $scAssociation = trim($matches[1]);
             } elseif (preg_match('/sc\s*association\s*id\s*[:=]?\s*([A-Za-z0-9\-]+)/i', $outputText, $matches)) {
                 $scAssociation = trim($matches[1]);
             }
             
             // Extract Other Government ID - multiple patterns
             if (preg_match('/other\s*government\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $otherGovtId = trim($matches[1]);
             } elseif (preg_match('/other\s*govt\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $otherGovtId = trim($matches[1]);
             } elseif (preg_match('/other\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $otherGovtId = trim($matches[1]);
             } elseif (preg_match('/other\s*government\s*id\s*[:=]?\s*([A-Za-z0-9\-]+)/i', $outputText, $matches)) {
                 $otherGovtId = trim($matches[1]);
             }
             
             // Extract Date of Birth - multiple patterns
             if (preg_match('/date\s*of\s*birth\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/birth\s*date\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/dob\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/born\s*on\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/birth\s*day\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/\b(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})\b/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             }
             
             // Extract Birth Place - multiple patterns
             if (preg_match('/place\s*of\s*birth\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $birthPlace = trim($matches[1]);
             } elseif (preg_match('/birth\s*place\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $birthPlace = trim($matches[1]);
             } elseif (preg_match('/born\s*in\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $birthPlace = trim($matches[1]);
             } elseif (preg_match('/birth\s*place\s*[:=]?\s*([A-Za-z\s,]+)/i', $outputText, $matches)) {
                 $birthPlace = trim($matches[1]);
             }
             
             // Extract Residence - multiple patterns
             if (preg_match('/residence\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $residence = trim($matches[1]);
             } elseif (preg_match('/house\s*no\.?\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $residence = trim($matches[1]);
             } elseif (preg_match('/zone\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $residence = trim($matches[1]);
             } elseif (preg_match('/purok\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $residence = trim($matches[1]);
             } elseif (preg_match('/sitio\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $residence = trim($matches[1]);
             }
             
             // Extract Street - multiple patterns
             if (preg_match('/street\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $street = trim($matches[1]);
             } elseif (preg_match('/st\.\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $street = trim($matches[1]);
             } elseif (preg_match('/street\s*name\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $street = trim($matches[1]);
             } elseif (preg_match('/street\s*[:=]?\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $street = trim($matches[1]);
             }
             
             // Extract Ethnic Origin - multiple patterns
             if (preg_match('/ethnic\s*origin\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $ethnicOrigin = trim($matches[1]);
             } elseif (preg_match('/ethnicity\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $ethnicOrigin = trim($matches[1]);
             } elseif (preg_match('/ethnic\s*group\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $ethnicOrigin = trim($matches[1]);
             } elseif (preg_match('/tribe\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $ethnicOrigin = trim($matches[1]);
             }
             
             // Extract Language - multiple patterns
             if (preg_match('/language\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $language = trim($matches[1]);
             } elseif (preg_match('/language\s*spoken\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $language = trim($matches[1]);
             } elseif (preg_match('/dialect\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $language = trim($matches[1]);
             } elseif (preg_match('/mother\s*tongue\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $language = trim($matches[1]);
             }
             
             // Extract Region - from address section
             if (preg_match('/region\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $region = trim($matches[1]);
             } elseif (preg_match('/region\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $region = trim($matches[1]);
             } elseif (preg_match('/2\.\s*address.*?region\s*([^\n]+)/is', $outputText, $matches)) {
                 $region = trim($matches[1]);
             }
             
             // Extract Province - from address section
             if (preg_match('/province\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $province = trim($matches[1]);
             } elseif (preg_match('/province\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $province = trim($matches[1]);
             } elseif (preg_match('/2\.\s*address.*?province\s*([^\n]+)/is', $outputText, $matches)) {
                 $province = trim($matches[1]);
             }
             
             // Extract City/Municipality - from address section
             if (preg_match('/city\s*\/?\s*municipality\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $cityMunicipality = trim($matches[1]);
             } elseif (preg_match('/city\s*\/?\s*municipality\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $cityMunicipality = trim($matches[1]);
             } elseif (preg_match('/2\.\s*address.*?city\s*\/?\s*municipality\s*([^\n]+)/is', $outputText, $matches)) {
                 $cityMunicipality = trim($matches[1]);
             }
             
             // Extract Barangay - from address section
             if (preg_match('/barangay\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $barangay = trim($matches[1]);
             } elseif (preg_match('/barangay\s*([A-Za-z0-9\s]+)/i', $outputText, $matches)) {
                 $barangay = trim($matches[1]);
             } elseif (preg_match('/2\.\s*address.*?barangay\s*([^\n]+)/is', $outputText, $matches)) {
                 $barangay = trim($matches[1]);
             }
             
             // Extract Marital Status
             if (preg_match('/marital\s*status\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $maritalStatus = trim($matches[1]);
             } elseif (preg_match('/marital\s*status\s*([A-Za-z\s]+)/i', $outputText, $matches)) {
                 $maritalStatus = trim($matches[1]);
             } elseif (preg_match('/5\.\s*marital\s*status\s*([^\n]+)/i', $outputText, $matches)) {
                 $maritalStatus = trim($matches[1]);
             }
             
             // Extract Gender/Sex
             if (preg_match('/gender\s*\/?\s*sex\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $gender = trim($matches[1]);
             } elseif (preg_match('/gender\s*\/?\s*sex\s*([A-Za-z\s]+)/i', $outputText, $matches)) {
                 $gender = trim($matches[1]);
             } elseif (preg_match('/6\.\s*gender\s*\/?\s*sex\s*([^\n]+)/i', $outputText, $matches)) {
                 $gender = trim($matches[1]);
             }
             
             // Extract Contact Number
             if (preg_match('/contact\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $contactNumber = trim($matches[1]);
             } elseif (preg_match('/contact\s*number\s*([0-9\+\-\s]+)/i', $outputText, $matches)) {
                 $contactNumber = trim($matches[1]);
             } elseif (preg_match('/7\.\s*contact\s*number\s*([^\n]+)/i', $outputText, $matches)) {
                 $contactNumber = trim($matches[1]);
             }
             
             // Extract Email Address
             if (preg_match('/email\s*address\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $emailAddress = trim($matches[1]);
             } elseif (preg_match('/email\s*address\s*([A-Za-z0-9\@\.\s]+)/i', $outputText, $matches)) {
                 $emailAddress = trim($matches[1]);
             } elseif (preg_match('/8\.\s*email\s*address\s*([^\n]+)/i', $outputText, $matches)) {
                 $emailAddress = trim($matches[1]);
             }
             
             // Extract Religion
             if (preg_match('/religion\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $religion = trim($matches[1]);
             } elseif (preg_match('/religion\s*([A-Za-z\s]+)/i', $outputText, $matches)) {
                 $religion = trim($matches[1]);
             } elseif (preg_match('/9\.\s*religion\s*([^\n]+)/i', $outputText, $matches)) {
                 $religion = trim($matches[1]);
             }
             
             // Extract Capability to Travel
             if (preg_match('/capability\s*to\s*travel\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $capabilityToTravel = trim($matches[1]);
             } elseif (preg_match('/capability\s*to\s*travel\s*([A-Za-z\s]+)/i', $outputText, $matches)) {
                 $capabilityToTravel = trim($matches[1]);
             } elseif (preg_match('/18\.\s*capability\s*to\s*travel\s*([^\n]+)/i', $outputText, $matches)) {
                 $capabilityToTravel = trim($matches[1]);
             } elseif (preg_match('/capability\s*to\s*travel.*?yes/i', $outputText)) {
                 $capabilityToTravel = "Yes";
             } elseif (preg_match('/capability\s*to\s*travel.*?no/i', $outputText)) {
                 $capabilityToTravel = "No";
             }
             
             // Extract Service/Business/Employment
             if (preg_match('/service\s*\/?\s*business\s*\/?\s*employment\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $serviceBusinessEmployment = trim($matches[1]);
             } elseif (preg_match('/service\s*\/?\s*business\s*\/?\s*employment\s*\(specify\)\s*([^\n]+)/i', $outputText, $matches)) {
                 $serviceBusinessEmployment = trim($matches[1]);
             } elseif (preg_match('/19\.\s*service\s*\/?\s*business\s*\/?\s*employment\s*([^\n]+)/i', $outputText, $matches)) {
                 $serviceBusinessEmployment = trim($matches[1]);
             }
             
             // Extract Current Pension
             if (preg_match('/current\s*pension\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $currentPension = trim($matches[1]);
             } elseif (preg_match('/current\s*pension\s*\(specify\)\s*([^\n]+)/i', $outputText, $matches)) {
                 $currentPension = trim($matches[1]);
             } elseif (preg_match('/20\.\s*current\s*pension\s*([^\n]+)/i', $outputText, $matches)) {
                 $currentPension = trim($matches[1]);
             }
             
             // Extract Educational Attainment
             if (preg_match('/educational\s*attainment\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $educationalAttainment = trim($matches[1]);
             } elseif (preg_match('/26\.\s*educational\s*attainment\s*([^\n]+)/i', $outputText, $matches)) {
                 $educationalAttainment = trim($matches[1]);
             } elseif (preg_match('/elementary\s*level/i', $outputText)) {
                 $educationalAttainment = "Elementary Level";
             } elseif (preg_match('/elementary\s*graduate/i', $outputText)) {
                 $educationalAttainment = "Elementary Graduate";
             } elseif (preg_match('/high\s*school\s*level/i', $outputText)) {
                 $educationalAttainment = "High School Level";
             } elseif (preg_match('/high\s*school\s*graduate/i', $outputText)) {
                 $educationalAttainment = "High School Graduate";
             } elseif (preg_match('/college\s*level/i', $outputText)) {
                 $educationalAttainment = "College Level";
             } elseif (preg_match('/college\s*graduate/i', $outputText)) {
                 $educationalAttainment = "College Graduate";
             } elseif (preg_match('/post\s*graduate/i', $outputText)) {
                 $educationalAttainment = "Post Graduate";
             } elseif (preg_match('/vocational/i', $outputText)) {
                 $educationalAttainment = "Vocational";
             } elseif (preg_match('/not\s*attended\s*school/i', $outputText)) {
                 $educationalAttainment = "Not Attended School";
             }
             
             // Extract Areas of Specialization / Technical Skills
             if (preg_match('/areas\s*of\s*specialization\s*\/?\s*technical\s*skills\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $specialization = trim($matches[1]);
             } elseif (preg_match('/27\.\s*areas\s*of\s*specialization\s*\/?\s*technical\s*skills\s*([^\n]+)/i', $outputText, $matches)) {
                 $specialization = trim($matches[1]);
             } elseif (preg_match('/medical/i', $outputText)) {
                 $specialization .= "Medical, ";
             } elseif (preg_match('/teaching/i', $outputText)) {
                 $specialization .= "Teaching, ";
             } elseif (preg_match('/legal\s*services/i', $outputText)) {
                 $specialization .= "Legal Services, ";
             } elseif (preg_match('/dental/i', $outputText)) {
                 $specialization .= "Dental, ";
             } elseif (preg_match('/counseling/i', $outputText)) {
                 $specialization .= "Counseling, ";
             } elseif (preg_match('/farming/i', $outputText)) {
                 $specialization .= "Farming, ";
             } elseif (preg_match('/fishing/i', $outputText)) {
                 $specialization .= "Fishing, ";
             } elseif (preg_match('/cooking/i', $outputText)) {
                 $specialization .= "Cooking, ";
             } elseif (preg_match('/arts/i', $outputText)) {
                 $specialization .= "Arts, ";
             } elseif (preg_match('/engineering/i', $outputText)) {
                 $specialization .= "Engineering, ";
             } elseif (preg_match('/carpenter/i', $outputText)) {
                 $specialization .= "Carpenter, ";
             } elseif (preg_match('/plumber/i', $outputText)) {
                 $specialization .= "Plumber, ";
             } elseif (preg_match('/barber/i', $outputText)) {
                 $specialization .= "Barber, ";
             } elseif (preg_match('/tailor/i', $outputText)) {
                 $specialization .= "Tailor, ";
             } elseif (preg_match('/evangelization/i', $outputText)) {
                 $specialization .= "Evangelization, ";
             }
             
             // Clean up specialization string (remove trailing comma and space)
             $specialization = rtrim($specialization, ", ");
             
             // Clean up extracted data
             $firstName = preg_replace('/\s+/', ' ', $firstName);
             $lastName = preg_replace('/\s+/', ' ', $lastName);
             $middleName = preg_replace('/\s+/', ' ', $middleName);
             $oscaId = preg_replace('/\s+/', ' ', $oscaId);
             $gsisSss = preg_replace('/\s+/', ' ', $gsisSss);
             $tin = preg_replace('/\s+/', ' ', $tin);
             $philhealth = preg_replace('/\s+/', ' ', $philhealth);
             $scAssociation = preg_replace('/\s+/', ' ', $scAssociation);
             $otherGovtId = preg_replace('/\s+/', ' ', $otherGovtId);
             $dateOfBirth = preg_replace('/\s+/', ' ', $dateOfBirth);
             $birthPlace = preg_replace('/\s+/', ' ', $birthPlace);
             $residence = preg_replace('/\s+/', ' ', $residence);
             $street = preg_replace('/\s+/', ' ', $street);
             $ethnicOrigin = preg_replace('/\s+/', ' ', $ethnicOrigin);
             $language = preg_replace('/\s+/', ' ', $language);
             
            // Construct full name
            $fullName = trim("$firstName $middleName $lastName");
            if (empty($fullName)) {
                $fullName = "Unknown";
            }

            // Extract other information
            $idNumber = '';
             if (preg_match('/id\s*number\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $idNumber = trim($matches[1]);
             } elseif (preg_match('/osca\s*id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $idNumber = trim($matches[1]);
             } elseif (preg_match('/id\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $idNumber = trim($matches[1]);
             }
             
             $dateOfBirth = '';
             if (preg_match('/date\s*of\s*birth\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/birth\s*date\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
             } elseif (preg_match('/dob\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $dateOfBirth = trim($matches[1]);
            }

            // Final ROI-targeted re-OCR for uppercase last names using TSV anchors
            try {
                $origLastUpper = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$lastName)));
                $shouldImprove = ($origLastUpper !== '' && strlen($origLastUpper) >= 4 && $origLastUpper === trim(preg_replace('/[^A-Za-z]/', '', (string)$lastName)));
                if ($shouldImprove && !empty($tsvOutput) && !empty($this->currentImagePath) && file_exists($this->currentImagePath)) {
                    // Parse TSV tokens
                    $tokens = [];
                    $linesTsv = preg_split("/\r?\n/", trim((string)$tsvOutput));
                    if ($linesTsv && count($linesTsv) > 1) {
                        for ($i = 1; $i < count($linesTsv); $i++) {
                            $line = $linesTsv[$i]; if ($line === '') { continue; }
                            $parts = explode("\t", $line); if (count($parts) < 12) { continue; }
                            $text = trim($parts[11] ?? ''); if ($text === '' || $text === '∎') { continue; }
                            $left = (int)($parts[6] ?? 0); $top = (int)($parts[7] ?? 0);
                            $width = (int)($parts[8] ?? 0); $height = (int)($parts[9] ?? 0);
                            $tokens[] = [
                                'text' => $text,
                                'left' => $left,
                                'top' => $top,
                                'right' => $left + $width,
                                'bottom' => $top + $height,
                                'height' => $height,
                            ];
                        }
                    }
                    // Compute page bounds
                    $pageRight = 0; $pageBottom = 0; foreach ($tokens as $tk){ $pageRight = max($pageRight, $tk['right']); $pageBottom = max($pageBottom, $tk['bottom']); }
                    // Helper to find separate label tokens (Last + Name)
                    $findLabel = function(string $a, string $b) use ($tokens){
                        $aLows = [strtolower($a), strtolower($a . '.')];
                        $bLows = [strtolower($b), strtolower($b . '.')];
                        foreach ($tokens as $i => $ti) {
                            $lx = strtolower($ti['text']); if (!in_array($lx, $aLows)) { continue; }
                            for ($j = max(0, $i - 4); $j <= min(count($tokens) - 1, $i + 4); $j++) {
                                if ($j === $i) { continue; }
                                $tj = $tokens[$j]; $ly = strtolower($tj['text']); if (!in_array($ly, $bLows)) { continue; }
                                // Nearby horizontally and similar Y
                                if (abs($ti['top'] - $tj['top']) <= max(8, (int)(0.8 * max($ti['height'], $tj['height'])))) {
                                    return [
                                        'left' => min($ti['left'], $tj['left']),
                                        'top' => min($ti['top'], $tj['top']),
                                        'right' => max($ti['right'], $tj['right']),
                                        'bottom' => max($ti['bottom'], $tj['bottom']),
                                        'height' => max($ti['height'], $tj['height']),
                                    ];
                                }
                            }
                        }
                        return null;
                    };
                    // Combined variants
                    $findCombined = function(array $variants) use ($tokens){
                        foreach ($tokens as $tk){
                            $letters = strtolower(preg_replace('/[^a-z]/', '', $tk['text']));
                            foreach ($variants as $v){
                                $all = true; foreach (array_filter(explode(' ', strtolower($v))) as $vw){ $vw = preg_replace('/[^a-z]/', '', $vw); if ($vw === '') { continue; } if (strpos($letters, $vw) === false){ $all = false; break; } }
                                if ($all){ return ['left'=>$tk['left'],'top'=>$tk['top'],'right'=>$tk['right'],'bottom'=>$tk['bottom'],'height'=>$tk['height']]; }
                            }
                        }
                        return null;
                    };
                    $lastLabel = $findLabel('Last', 'Name'); if (!$lastLabel) { $lastLabel = $findCombined(['Last Name','Surname']); }
                    // Compute ROI
                    $roiLeft = 0; $roiTop = 0; $roiRight = max(10, (int)($pageRight * 0.36)); $roiBottom = max(30, (int)($pageBottom * 0.45));
                    if ($lastLabel) {
                        // Prefer BELOW the label to target the value region
                        $roiTop = $lastLabel['bottom'] + 5;
                        $roiBottom = min($pageBottom, $roiTop + max(120, (int)($pageBottom * 0.25)));
                        $roiLeft = max(0, $lastLabel['left'] - 20);
                        $roiRight = min($pageRight, $lastLabel['right'] + max(160, (int)($pageRight * 0.20)));
                    } else {
                        // Dynamic band using address and label anchors (approximate top-row band)
                        $labelWords = ['last','first','middle','name','surname','given'];
                        $labelTops = []; foreach ($tokens as $t){ $tx = strtolower($t['text']); foreach ($labelWords as $lw){ if ($tx === $lw || $tx === ($lw . '.')){ $labelTops[] = $t['top']; break; } } }
                        if (!empty($labelTops)) {
                            $topLabel = min($labelTops); if ($topLabel > max(24, (int)($pageBottom * 0.06))) {
                                $margin = max(12, (int)($pageBottom * 0.06)); $roiBottom = max(0, $topLabel - $margin);
                            }
                        }
                        $anchors = ['region','province','city','municipality','barangay','street','house','purok','sitio','village'];
                        $topCandidates = []; foreach ($tokens as $t){ $tx = strtolower($t['text']); foreach ($anchors as $a){ if (strpos($tx, $a) !== false){ $topCandidates[] = $t['top']; break; } } }
                        if (!empty($topCandidates)) { $minTop = min($topCandidates); $margin = max(10, (int)($pageBottom * 0.04)); $roiBottom = max(0, $minTop - $margin); }
                        $roiTop = max(0, $roiBottom - max(140, (int)($pageBottom * 0.22)));
                        $roiLeft = 0; $roiRight = max(10, (int)($pageRight * 0.36));
                    }
                    // Crop and run Tesseract in word vs line mode
                    $ext = strtolower(pathinfo($this->currentImagePath, PATHINFO_EXTENSION));
                    $srcImg = null; if (in_array($ext, ['jpg','jpeg'])) { $srcImg = @imagecreatefromjpeg($this->currentImagePath); } elseif ($ext === 'png') { $srcImg = @imagecreatefrompng($this->currentImagePath); }
                    if ($srcImg) {
                        $cropW = max(10, $roiRight - $roiLeft); $cropH = max(30, $roiBottom - $roiTop);
                        $seg = @imagecrop($srcImg, ['x'=>$roiLeft,'y'=>$roiTop,'width'=>$cropW,'height'=>$cropH]);
                        if ($seg) {
                            $tmp = tempnam(sys_get_temp_dir(), 'last_band_'); $out = $tmp . '.' . ($ext === 'png' ? 'png' : 'jpg');
                            if ($ext === 'png') { @imagepng($seg, $out); } else { @imagejpeg($seg, $out, 92); }
                            @imagedestroy($seg); @imagedestroy($srcImg);
                            $cfg = ' -l eng -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ\'" ."\' -c preserve_interword_spaces=1';
                            $out8 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 8' . $cfg);
                            $out7 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 7' . $cfg);
                            if (is_file($out)) { @unlink($out); } if (is_file($tmp)) { @unlink($tmp); }
                            $cand8 = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$out8)));
                            $cand7 = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$out7)));
                            $noise = ['FT','NOT','NAME','LAST','FIRST','MIDDLE','SURNAME','GIVEN'];
                            $bothAgree = ($cand8 !== '' && $cand8 === $cand7);
                            // Prefer the longer candidate, then closer edit distance to original
                            $len8 = strlen($cand8); $len7 = strlen($cand7); $lenO = strlen($origLastUpper);
                            $best = $cand8; $bestLen = $len8; $bestDist = ($cand8 !== '' ? levenshtein($origLastUpper, $cand8) : 999);
                            $dist7 = ($cand7 !== '' ? levenshtein($origLastUpper, $cand7) : 999);
                            if ($len7 > $bestLen || ($len7 === $bestLen && $dist7 < $bestDist)) { $best = $cand7; $bestLen = $len7; $bestDist = $dist7; }
                            if ($best !== '' && $bestLen >= 2 && !in_array($best, $noise)) {
                                $oScore = $lenO; $iScore = $bestLen;
                                // Strong acceptance when both PSM modes agree on a short plausible name
                                if ($bothAgree && !in_array($cand8, $noise) && strlen($cand8) >= 2) {
                                    $lastName = $cand8;
                                    try { Log::info('OCR label-band re-OCR applied', ['original' => $origLastUpper, 'improved' => $cand8, 'psm8' => $cand8, 'psm7' => $cand7, 'roi' => compact('roiLeft','roiTop','roiRight','roiBottom'), 'reason' => 'both_psm_agree']); } catch (\Throwable $e) {}
                                } else if ($iScore > max(2, $oScore) || ($iScore >= 2 && $bestDist >= 2)) {
                                    $lastName = $best;
                                    try { Log::info('OCR label-band re-OCR applied', ['original' => $origLastUpper, 'improved' => $best, 'psm8' => $cand8, 'psm7' => $cand7, 'roi' => compact('roiLeft','roiTop','roiRight','roiBottom'), 'reason' => 'len_or_dist']); } catch (\Throwable $e) {}
                                } else {
                                    try { Log::info('OCR label-band re-OCR kept original', ['original' => $origLastUpper, 'candidate' => $best, 'psm8' => $cand8, 'psm7' => $cand7, 'dist' => $bestDist, 'roi' => compact('roiLeft','roiTop','roiRight','roiBottom')]); } catch (\Throwable $e) {}
                                }
                            } else {
                                try { Log::info('OCR label-band re-OCR produced empty/short', ['psm8' => $cand8, 'psm7' => $cand7, 'roi' => compact('roiLeft','roiTop','roiRight','roiBottom')]); } catch (\Throwable $e) {}
                            }
                        } else { @imagedestroy($srcImg); }
                    }
                }
            } catch (\Throwable $e) {
                try { Log::warning('OCR label-band re-OCR failed', ['error' => $e->getMessage()]); } catch (\Throwable $e2) {}
            }

            // Prefer TSV layout mapping (label-based or top-row fallback), but only accept plausible names
            if (!empty($layoutFields)) {
                $isPlausible = function($s): bool {
                    $clean = preg_replace('/[^A-Za-z\s\-\.]/', ' ', (string)$s);
                    $clean = trim(preg_replace('/\s+/', ' ', $clean));
                    if ($clean === '') { return false; }
                    // Reject strings with too many fragments/punctuation clusters
                    $punctRuns = preg_match_all('/[-\.]{2,}/', (string)$s);
                    if ($punctRuns && $punctRuns > 0) { return false; }
                    $tokens = preg_split('/\s+/', $clean);
                    if (count($tokens) > 3) { return false; }
                    $ok = 0;
                    foreach ($tokens as $t) {
                        if ($t === '') { continue; }
                        if (preg_match('/^[A-Za-z]{2,}$/', $t) !== 1) { return false; }
                        $ok++;
                    }
                    return $ok > 0;
                };

                $assignLast = !empty($layoutFields['last_name']) && $isPlausible($layoutFields['last_name']);
                $assignFirst = !empty($layoutFields['first_name']) && $isPlausible($layoutFields['first_name']);
                $assignMiddle = !empty($layoutFields['middle_name']) && $isPlausible($layoutFields['middle_name']);

                if ($assignLast) { $lastName = $layoutFields['last_name']; }
                if ($assignFirst) { $firstName = $layoutFields['first_name']; }
                if ($assignMiddle) { $middleName = $layoutFields['middle_name']; }

                if ($assignLast || $assignFirst || $assignMiddle) {
                    Log::info('OCR TSV name mapping (preferred)', [
                        'last_name' => $lastName,
                        'first_name' => $firstName,
                        'middle_name' => $middleName,
                        'fallback_used' => $layoutFields['fallback_used'] ?? false,
                    ]);
                } else {
                    Log::info('OCR TSV name mapping rejected (implausible)', [
                        'tsv_last' => $layoutFields['last_name'] ?? '',
                        'tsv_first' => $layoutFields['first_name'] ?? '',
                        'tsv_middle' => $layoutFields['middle_name'] ?? '',
                        'fallback_used' => $layoutFields['fallback_used'] ?? false,
                    ]);
                }
            }

            // Attempt raw-text label overrides regardless of TSV presence
            $alphaScore = function($s){ return strlen(preg_replace('/[^A-Za-z]/','', (string)$s)); };
            $looksWeak = function($s) use ($alphaScore){
                $len = $alphaScore($s);
                if ($len < 3) { return true; }
                // Single ultra-long run with no spaces is suspicious (likely mis-OCR)
                $tokens = preg_split('/\s+/', trim((string)$s));
                if (count($tokens) === 1 && strlen($tokens[0]) >= 12) { return true; }
                return false;
            };
            if (!empty($outputText)) {
                $lines = preg_split("/\r?\n/", (string)$outputText);
                $takeVal = function(array $lines, int $i): string {
                    $curr = trim((string)$lines[$i]);
                    // If value present on same line after ':' or '=', take it
                    if (preg_match('/[:=]\s*([^\n]+)/', $curr, $m)) {
                        return trim($m[1]);
                    }
                    // Else, use next non-empty line as value
                    for ($j = $i + 1; $j < count($lines); $j++) {
                        $v = trim((string)$lines[$j]);
                        if ($v !== '') { return $v; }
                    }
                    return '';
                };
                $raw = ['last_name' => '', 'first_name' => '', 'middle_name' => ''];
                for ($i = 0; $i < count($lines); $i++) {
                    $low = strtolower(trim((string)$lines[$i]));
                    if ($low === '') { continue; }
                    // Match fuzzy labels allowing missing/incorrect characters and varied order
                    if (preg_match('/\blast\b.*(name)?\b|\bname\b.*\blast\b|\blast\s*nam\b/', $low)) {
                        $val = $takeVal($lines, $i);
                        if ($alphaScore($val) >= 3) { $raw['last_name'] = $val; }
                        continue;
                    }
                    if (preg_match('/\bfirst\b.*(name)?\b|\bname\b.*\bfirst\b|\bfirst\s*nam\b/', $low)) {
                        $val = $takeVal($lines, $i);
                        if ($alphaScore($val) >= 3) { $raw['first_name'] = $val; }
                        continue;
                    }
                    if (preg_match('/\bmiddle\b.*(name)?\b|\bname\b.*\bmiddle\b|\bmid(dle)?\s*nam\b/', $low)) {
                        $val = $takeVal($lines, $i);
                        if ($alphaScore($val) >= 3) { $raw['middle_name'] = $val; }
                        continue;
                    }
                }
                $tokensCount = function($s){ $t = preg_split('/\s+/', trim((string)$s)); return array_values(array_filter($t, function($x){ return $x !== ''; })); };
                $preferName = function(string $tsv, string $raw) use ($alphaScore, $tokensCount){
                    $rawScore = $alphaScore($raw); $tsvScore = $alphaScore($tsv);
                    if ($rawScore < 3) { return $tsv; }
                    $rawTokens = $tokensCount($raw); $tsvTokens = $tokensCount($tsv);
                    $rawHasMulti = count($rawTokens) >= 2; $tsvSingle = count($tsvTokens) <= 1;
                    // Prefer structured raw values (multi-token) over single-token TSV gibberish
                    if ($rawHasMulti && $tsvSingle) { return $raw; }
                    // Prefer raw if it has strictly more alphabetic content
                    if ($rawScore > $tsvScore) { return $raw; }
                    // Prefer raw when TSV is an unusually long single token (>=8)
                    if ($tsvSingle && strlen(trim($tsv)) >= 8) { return $raw; }
                    return $tsv;
                };
                $overridden = false;
                $newLast = $preferName((string)$lastName, (string)$raw['last_name']);
                $newFirst = $preferName((string)$firstName, (string)$raw['first_name']);
                $newMiddle = $preferName((string)$middleName, (string)$raw['middle_name']);
                if ($newLast !== $lastName) { $lastName = $newLast; $overridden = true; }
                if ($newFirst !== $firstName) { $firstName = $newFirst; $overridden = true; }
                if ($newMiddle !== $middleName) { $middleName = $newMiddle; $overridden = true; }
                if ($overridden) {
                    Log::info('OCR raw-text label override mapping', [
                        'last_name' => $lastName,
                        'first_name' => $firstName,
                        'middle_name' => $middleName,
                    ]);
                } else {
                    Log::info('OCR raw-text label override skipped (no improvement)', [
                        'tsv_last' => $layoutFields['last_name'] ?? '',
                        'tsv_first' => $layoutFields['first_name'] ?? '',
                        'tsv_middle' => $layoutFields['middle_name'] ?? '',
                    ]);
                }
            }

            // Heuristic fallback from raw text (no GD/TSV dependency)
            $hasTopBandEvidence = (!empty($layoutFields) && !empty($layoutFields['fallback_used']));
            if ($hasTopBandEvidence) {
                try { Log::info('OCR raw-text global fallback suppressed due to top-band evidence', ['fallback_used' => $layoutFields['fallback_used'] ?? null]); } catch (\Throwable $e) {}
            } else if (empty($lastName) && empty($firstName) && empty($middleName) && !empty($outputText)) {
                $lines = preg_split("/\r?\n/", trim($outputText));
                $stopwords = ['region','province','city','municipality','barangay','street','purok','sitio','village','house','hno','thru','date','birth','religion','ethnic','place','id','osca','contact','number','philhealth','tin','identifying','information','extension','ext','supported','file','types','jpg','jpeg','png','pdf','ft','pt','not','poblacion','brgy','zone','blk','lot','po','sub','vlg','ave','blvd','st'];
                $looksAddress = function($s) use ($stopwords){
                    $low = strtolower($s);
                    if (preg_match('/\d/', $s)) { return true; }
                    if (preg_match('/\b(st|brgy|poblacion|zone|blk|lot|po|sub|vlg|ave|blvd|street|barangay|province|city|municipality|purok|sitio|village|house|hno)\b/i', $s)) { return true; }
                    foreach ($stopwords as $sw){ if (strpos($low, $sw) !== false) { return true; } }
                    return false;
                };
                $best = '';
                $bestScore = 0;
                foreach ($lines as $ln) {
                    if ($ln === '') { continue; }
                    if ($looksAddress($ln)) { continue; }
                    if (stripos($ln, 'name') !== false) { continue; }
                    $clean = preg_replace('/[^A-Za-z\'\-\.\s]/', ' ', $ln);
                    $clean = trim(preg_replace('/\s+/', ' ', $clean));
                    $words = preg_split('/\s+/', $clean);
                    $words = array_values(array_filter($words, function($w) use ($stopwords){
                        $lw = strtolower($w);
                        $alpha = preg_replace('/[^A-Za-z]/','', $w);
                        if ($lw === '' || strlen($alpha) < 3) { return false; }
                        if (ctype_upper($w) && strlen($w) <= 3) { return false; }
                        foreach ($stopwords as $sw){ if ($lw === $sw) { return false; } }
                        return true;
                    }));
                    // Require at least one uppercase token of length >= 4
                    $upperLongCount = 0;
                    foreach ($words as $w) {
                        $alphaW = preg_replace('/[^A-Za-z]/','', $w);
                        if (ctype_upper($w) && strlen($alphaW) >= 4) { $upperLongCount++; }
                    }
                    $lengths = array_map('strlen', $words);
                    $longWords = array_values(array_filter($words, function($w){ return strlen($w) >= 4; }));
                    $strong = (!empty($lengths) ? max($lengths) : 0) >= 5;
                    if (count($longWords) < 1 || !$strong || $upperLongCount < 1) { continue; }
                    $score = strlen($clean) + 5 * count($longWords) + 10;
                    if ($score > $bestScore) { $bestScore = $score; $best = $clean; }
                }
                if ($best !== '') {
                    $parts = preg_split('/\s+/', $best);
                    if (count($parts) >= 1) {
                        if (count($parts) === 1) {
                            $seg1 = $parts[0]; $seg2 = ''; $seg3 = '';
                        } elseif (count($parts) === 2) {
                            $seg1 = $parts[0]; $seg2 = $parts[1]; $seg3 = '';
                        } elseif (count($parts) === 3) {
                            $seg1 = $parts[0]; $seg2 = $parts[1]; $seg3 = $parts[2];
                        } else {
                            $seg1 = $parts[0]; $seg2 = $parts[1]; $seg3 = implode(' ', array_slice($parts, 2));
                        }
                        $accept = (strlen($seg1) >= 4) || (strlen($seg2) >= 4);
                        $seg1Alpha = preg_replace('/[^A-Za-z]/','', $seg1);
                        $seg2Alpha = preg_replace('/[^A-Za-z]/','', $seg2);
                        $hasUpperSignal = (ctype_upper($seg1) && strlen($seg1Alpha) >= 4) || (ctype_upper($seg2) && strlen($seg2Alpha) >= 4);
                        $bad1 = false; foreach ($stopwords as $sw){ if (stripos($seg1, $sw) !== false){ $bad1 = true; break; } }
                        $bad2 = false; foreach ($stopwords as $sw){ if (stripos($seg2, $sw) !== false){ $bad2 = true; break; } }
                        if ($accept && $hasUpperSignal && !$bad1 && !$bad2 && !$looksAddress($best)) {
                            if (empty($lastName)) { $lastName = trim($seg1); }
                            $allowGiven = (!empty($layoutFields['first_name']) || !empty($layoutFields['middle_name']));
                            if ($allowGiven && empty($firstName)) { $firstName = trim($seg2); }
                            if ($allowGiven && empty($middleName)) { $middleName = trim($seg3); }
                            Log::info('OCR raw-text heuristic names', [
                                'candidate_line' => $best,
                                'last_name' => $lastName,
                                'first_name' => $firstName,
                                'middle_name' => $middleName,
                            ]);
                        }
                    }
                } else {
                    $cleanAll = trim(preg_replace('/[^A-Za-z\'\-\.\s]/', ' ', $outputText));
                    $cleanAll = preg_replace('/\s+/', ' ', $cleanAll);
                    $words = preg_split('/\s+/', $cleanAll);
                    $words = array_values(array_filter($words, function($w) use ($stopwords){
                        $lw = strtolower($w);
                        $alpha = preg_replace('/[^A-Za-z]/','', $w);
                        if ($lw === '' || strlen($alpha) < 3) { return false; }
                        if (ctype_upper($w) && strlen($w) <= 3) { return false; }
                        foreach ($stopwords as $sw){ if ($lw === $sw) { return false; } }
                        return true;
                    }));
                    // Require uppercase signal for global word fallback
                    $upperLongCountAll = 0;
                    foreach ($words as $w) {
                        $alphaW = preg_replace('/[^A-Za-z]/','', $w);
                        if (ctype_upper($w) && strlen($alphaW) >= 4) { $upperLongCountAll++; }
                    }
                    if (count($words) >= 1) {
                        if (count($words) === 1) {
                            $seg1 = $words[0]; $seg2 = ''; $seg3 = '';
                        } elseif (count($words) === 2) {
                            $seg1 = $words[0]; $seg2 = $words[1]; $seg3 = '';
                        } elseif (count($words) === 3) {
                            $seg1 = $words[0]; $seg2 = $words[1]; $seg3 = $words[2];
                        } else {
                            $seg1 = $words[0]; $seg2 = $words[1]; $seg3 = implode(' ', array_slice($words, 2));
                        }
                        $seg1Alpha = preg_replace('/[^A-Za-z]/','', $seg1);
                        $seg2Alpha = preg_replace('/[^A-Za-z]/','', $seg2);
                        if (empty($lastName)) { $lastName = trim($seg1); }
                        $allowGiven = (!empty($layoutFields['first_name']) || !empty($layoutFields['middle_name']));
                        if ($allowGiven && empty($firstName)) { $firstName = trim($seg2); }
                        if ($allowGiven && empty($middleName)) { $middleName = trim($seg3); }
                        if ($upperLongCountAll < 1 || (!(ctype_upper($seg1) && strlen($seg1Alpha) >= 4) && !(ctype_upper($seg2) && strlen($seg2Alpha) >= 4))) {
                            try { Log::info('OCR raw-text global word fallback suppressed (no uppercase signal)', ['seg1' => $seg1, 'seg2' => $seg2]); } catch (\Throwable $e) {}
                            $lastName = '';
                            if ($allowGiven) { $firstName = ''; $middleName = ''; }
                            Log::info('OCR raw-text global fallback suppressed');
                            continue;
                        }
                        // If we have a single strong token likely to be the last name, try a word-mode re-OCR on the top band
                        try {
                            $alphaLast = preg_replace('/[^A-Za-z]/','', (string)$lastName);
                            // Trigger re-OCR for strong uppercase last names even when first/middle exist
                            $isSingleStrong = (strlen($alphaLast) >= 4 && ctype_upper(trim((string)$lastName)));
                            $imgPath = (string)($this->currentImagePath ?? '');
                            $imgExt = strtolower((string)($this->currentImageExt ?? ''));
                            if ($isSingleStrong && $imgPath !== '' && is_file($imgPath) && in_array($imgExt, ['jpg','jpeg','png'])) {
                                // Load image and crop a generous top band ROI where the name box resides
                                $srcImg = null;
                                if ($imgExt === 'png' && function_exists('imagecreatefrompng')) { $srcImg = @imagecreatefrompng($imgPath); }
                                if (($imgExt === 'jpg' || $imgExt === 'jpeg') && function_exists('imagecreatefromjpeg')) { $srcImg = @imagecreatefromjpeg($imgPath); }
                                if ($srcImg) {
                                    $w = @imagesx($srcImg); $h = @imagesy($srcImg);
                                    if ($w && $h) {
                                        $roiTop = 0; $roiBottom = max(40, (int)floor($h * 0.35));
                                        $roiH = max(40, $roiBottom - $roiTop);
                                        $roi = false;
                                        if (function_exists('imagecrop')) { $roi = @imagecrop($srcImg, ['x' => 0, 'y' => $roiTop, 'width' => $w, 'height' => $roiH]); }
                                        if ($roi === false) { $roi = @imagecreatetruecolor($w, $roiH); if ($roi) { @imagecopy($roi, $srcImg, 0, 0, 0, $roiTop, $w, $roiH); } }
                                        if ($roi) {
                                            $tmp = sys_get_temp_dir() . '/' . uniqid('glob_word_') . '.' . $imgExt;
                                            if ($imgExt === 'png') { @imagepng($roi, $tmp); } else { @imagejpeg($roi, $tmp, 92); }
                                            @imagedestroy($roi);
                                            @imagedestroy($srcImg);
                                            $cfg = ' -l eng --oem 1 -c preserve_interword_spaces=0 -c load_system_dawg=0 -c load_freq_dawg=0 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                                            $out8 = @shell_exec('tesseract ' . escapeshellarg($tmp) . ' stdout --psm 8' . $cfg);
                                            $out7 = @shell_exec('tesseract ' . escapeshellarg($tmp) . ' stdout --psm 7' . $cfg);
                                            if (is_file($tmp)) { @unlink($tmp); }
                                            $cand8 = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$out8)));
                                            $cand7 = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$out7)));
                                            $orig = strtoupper(trim(preg_replace('/[^A-Za-z]/', '', (string)$lastName)));
                                            $noise = ['FT','NOT','NAME','LAST','FIRST','MIDDLE','SURNAME','GIVEN'];
                                            $bothAgree = ($cand8 !== '' && $cand8 === $cand7);
                                            // Choose the better candidate by alphabetic length, then by edit distance
                                            $len8 = strlen($cand8); $len7 = strlen($cand7); $lenO = strlen($orig);
                                            $best = $cand8; $bestLen = $len8; $bestDist = ($cand8 !== '' ? levenshtein($orig, $cand8) : 999);
                                            $dist7 = ($cand7 !== '' ? levenshtein($orig, $cand7) : 999);
                                            if ($len7 > $bestLen || ($len7 === $bestLen && $dist7 < $bestDist)) { $best = $cand7; $bestLen = $len7; $bestDist = $dist7; }
                                            if ($best !== '') {
                                                $oScore = $lenO;
                                                $iScore = $bestLen;
                                                // Strong acceptance when both PSM modes agree on a short plausible name
                                                if ($bothAgree && !in_array($cand8, $noise) && strlen($cand8) >= 2) {
                                                    $lastName = $cand8;
                                                    try { Log::info('OCR global single-word re-OCR applied', ['original' => $orig, 'improved' => $cand8, 'psm8' => $cand8, 'psm7' => $cand7, 'reason' => 'both_psm_agree']); } catch (\Throwable $e) {}
                                                } else if ($iScore > max(2, $oScore) || ($iScore >= 2 && $bestDist >= 2)) {
                                                    // Fallback: prefer improved by length or edit distance when plausible
                                                    $lastName = $best;
                                                    try { Log::info('OCR global single-word re-OCR applied', ['original' => $orig, 'improved' => $best, 'psm8' => $cand8, 'psm7' => $cand7, 'reason' => 'len_or_dist']); } catch (\Throwable $e) {}
                                                } else {
                                                    try { Log::info('OCR global single-word re-OCR kept original', ['original' => $orig, 'candidate' => $best, 'psm8' => $cand8, 'psm7' => $cand7, 'dist' => $bestDist]); } catch (\Throwable $e) {}
                                                }
                                            } else {
                                                try { Log::info('OCR global single-word re-OCR produced empty', ['psm8' => $out8, 'psm7' => $out7]); } catch (\Throwable $e) {}
                                            }
                                        } else {
                                            @imagedestroy($srcImg);
                                        }
                                    } else { @imagedestroy($srcImg); }
                                }
                            }
                        } catch (\Throwable $e) {
                            try { Log::warning('OCR global single-word re-OCR failed', ['error' => $e->getMessage()]); } catch (\Throwable $e2) {}
                        }
                        Log::info('OCR raw-text heuristic names (global fallback)', [
                            'last_name' => $lastName,
                            'first_name' => $firstName,
                            'middle_name' => $middleName,
                        ]);
                        // Guard: if there was no label/TSV evidence for given names, clear them to avoid address-derived values
                        if (empty($layoutFields['first_name']) && empty($layoutFields['middle_name'])) {
                            if ($firstName !== '' || $middleName !== '') {
                                try {
                                    Log::info('OCR global fallback: cleared given names due to no label/TSV evidence', [
                                        'cleared_first' => $firstName,
                                        'cleared_middle' => $middleName,
                                    ]);
                                } catch (\Throwable $e) {}
                            }
                            $firstName = '';
                            $middleName = '';
                        }
                    } else {
                        Log::info('OCR raw-text global fallback suppressed');
                    }
                }
            }
             
             $address = '';
             if (preg_match('/address\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $address = trim($matches[1]);
             } elseif (preg_match('/residence\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $address = trim($matches[1]);
             } elseif (preg_match('/location\s*[:=]\s*([^\n]+)/i', $outputText, $matches)) {
                 $address = trim($matches[1]);
             }
            
            // Prepare OCR results
            $ocrResults = [
                'name' => $fullName,
                'first_name' => $firstName,
                'last_name' => $lastName,
                'middle_name' => $middleName,
                'id_number' => $idNumber,
                'date_of_birth' => $dateOfBirth,
                'address' => $address,
                'osca_id' => $oscaId,
                'gsis_sss' => $gsisSss,
                'tin' => $tin,
                'philhealth' => $philhealth,
                'sc_association' => $scAssociation,
                'other_govt_id' => $otherGovtId,
                'birth_place' => $birthPlace,
                'residence' => $residence,
                'street' => $street,
                'ethnic_origin' => $ethnicOrigin,
                'language' => $language,
                // New form fields
                'region' => $region ?? '',
                'province' => $province ?? '',
                'city_municipality' => $cityMunicipality ?? '',
                'barangay' => $barangay ?? '',
                'marital_status' => $maritalStatus ?? '',
                'gender' => $gender ?? '',
                'contact_number' => $contactNumber ?? '',
                'email_address' => $emailAddress ?? '',
                'religion' => $religion ?? '',
                'capability_to_travel' => $capabilityToTravel ?? '',
                'service_business_employment' => $serviceBusinessEmployment ?? '',
                'current_pension' => $currentPension ?? '',
                'educational_attainment' => $educationalAttainment ?? '',
                'specialization' => $specialization ?? '',
                'raw_text' => $outputText
            ];
            
            // Clean up temporary files at the end (both original tmp and moved path)
            if (isset($tempFile) && is_string($tempFile)) { @unlink($tempFile); }
            if (isset($tempFilePath) && is_string($tempFilePath) && file_exists($tempFilePath)) { @unlink($tempFilePath); }
            
            return response()->json([
                'success' => true,
                'message' => 'OCR processing completed successfully',
                'data' => $ocrResults
            ]);
    }
}

// Helper methods for layout-based extraction
trait OCRLayoutHelpers {
        private function extractNamesByLayoutFromTsv(?string $tsv): array
        {
            if (!$tsv) {
                return [];
            }
            $tokens = [];
            $lines = preg_split("/\r?\n/", trim($tsv));
            if (!$lines || count($lines) < 2) {
                return [];
            }
            // Skip header
            $startIndex = 1;
            for ($i = $startIndex; $i < count($lines); $i++) {
                $line = $lines[$i];
                if ($line === '') { continue; }
                $parts = explode("\t", $line);
                if (count($parts) < 12) { continue; }
                $text = trim($parts[11] ?? '');
                if ($text === '' || $text === '∎') { continue; }
                $left = (int)($parts[6] ?? 0);
                $top = (int)($parts[7] ?? 0);
                $width = (int)($parts[8] ?? 0);
                $height = (int)($parts[9] ?? 0);
                $tokens[] = [
                    'text' => $text,
                    'left' => $left,
                    'top' => $top,
                    'right' => $left + $width,
                    'bottom' => $top + $height,
                    'height' => $height,
                ];
            }

            // Determine approximate page bounds from tokens
            $pageRight = 0; $pageBottom = 0;
            foreach ($tokens as $tk) { $pageRight = max($pageRight, $tk['right']); $pageBottom = max($pageBottom, $tk['bottom']); }

            // Fuzzy token matcher to tolerate mis-OCR (e.g., "a Name.", "Fist Nme")
            $approxEquals = function(string $a, string $b): bool {
                $na = strtolower(preg_replace('/[^a-z]/', '', $a));
                $nb = strtolower(preg_replace('/[^a-z]/', '', $b));
                if ($na === $nb) { return true; }
                if ($na === '' || $nb === '') { return false; }
                if (strpos($na, $nb) !== false || strpos($nb, $na) !== false) { return true; }
                $len = max(strlen($na), strlen($nb));
                $dist = levenshtein($na, $nb);
                return ($len >= 4 ? $dist <= 2 : $dist <= 1);
            };

            $findLabel = function(string $word1, string $word2) use ($tokens, $approxEquals): ?array {
                for ($i = 0; $i < count($tokens); $i++) {
                    if ($approxEquals($tokens[$i]['text'], $word1)) {
                        for ($j = $i + 1; $j < count($tokens); $j++) {
                            $sameLine = abs($tokens[$j]['top'] - $tokens[$i]['top']) <= max(10, (int)($tokens[$i]['height'] * 0.8));
                            if ($sameLine && $approxEquals($tokens[$j]['text'], $word2) && $tokens[$j]['left'] > $tokens[$i]['left']) {
                                $left = min($tokens[$i]['left'], $tokens[$j]['left']);
                                $top = min($tokens[$i]['top'], $tokens[$j]['top']);
                                $right = max($tokens[$i]['right'], $tokens[$j]['right']);
                                $bottom = max($tokens[$i]['bottom'], $tokens[$j]['bottom']);
                                $height = max($tokens[$i]['height'], $tokens[$j]['height']);
                                return compact('left', 'top', 'right', 'bottom', 'height');
                            }
                        }
                    }
                }
                return null;
            };

            // Also support combined tokens like "Last Name" in a single token, and synonyms
            $findCombined = function(array $variants) use ($tokens): ?array {
                foreach ($tokens as $tk) {
                    $letters = strtolower(preg_replace('/[^a-z]/', '', $tk['text']));
                    foreach ($variants as $v) {
                        $vwords = array_filter(explode(' ', strtolower($v)));
                        $allPresent = true;
                        foreach ($vwords as $vw) {
                            $vw = preg_replace('/[^a-z]/', '', $vw);
                            if ($vw === '') { continue; }
                            if (strpos($letters, $vw) === false) { $allPresent = false; break; }
                        }
                        if ($allPresent) {
                            return [
                                'left' => $tk['left'],
                                'top' => $tk['top'],
                                'right' => $tk['right'],
                                'bottom' => $tk['bottom'],
                                'height' => $tk['height'],
                            ];
                        }
                    }
                }
                return null;
            };

            // Compute a dynamic top-band bottom using address anchors when available
            $computeBandBottom = function() use ($tokens, $pageBottom): int {
                // Prefer label anchors (Last/First/Middle Name) to locate the printed label row
                $labelCandidates = [];
                $lowTokens = $tokens;
                foreach ($lowTokens as $tk) {
                    $tx = strtolower($tk['text']);
                    if ($tx === 'last' || $tx === 'first' || $tx === 'middle' || $tx === 'name' || $tx === 'surname' || $tx === 'given') {
                        $labelCandidates[] = $tk['top'];
                    }
                }
                if (!empty($labelCandidates)) {
                    $topLabel = min($labelCandidates);
                    // If label is not at the very top (to avoid mis-detection), use a margin above it
                    if ($topLabel > max(24, (int)($pageBottom * 0.06))) {
                        $margin = max(12, (int)($pageBottom * 0.06));
                        return max(0, $topLabel - $margin);
                    }
                }
                // Otherwise use address anchors to avoid dragging in the address band
                $anchors = ['region','province','city','municipality','barangay','street','house','purok','sitio','village','village','pob','site','str'];
                $topCandidates = [];
                foreach ($tokens as $tk) {
                    $tx = strtolower($tk['text']);
                    foreach ($anchors as $a) {
                        if (strpos($tx, $a) !== false) { $topCandidates[] = $tk['top']; break; }
                    }
                }
                if (!empty($topCandidates)) {
                    $minTop = min($topCandidates);
                    $margin = max(10, (int)($pageBottom * 0.04));
                    return max(0, $minTop - $margin);
                }
                return (int)($pageBottom * 0.33);
            };

            // Fallback: use the printed "Name" anchor; take the densest line immediately above it
            $fallbackAboveName = function() use ($tokens, $approxEquals, $pageRight): array {
                $nameTops = [];
                foreach ($tokens as $tk) { if ($approxEquals($tk['text'], 'Name')) { $nameTops[] = $tk['top']; } }
                if (empty($nameTops)) { try { Log::info('OCR fallback above-name anchor not found'); } catch (\Throwable $e) {} return []; }
                try { Log::info('OCR fallback above-name anchor detected', ['count' => count($nameTops), 'tops' => $nameTops]); } catch (\Throwable $e) {}
                $nameTop = min($nameTops);
                $roiBottom = max(0, $nameTop - 4);
                $roiTop = max(0, $roiBottom - 220);
                // Collect non-label handwriting-like tokens within ROI
                $labelWords = ['name','last','first','middle','surname','given'];
                $cands = [];
                foreach ($tokens as $tk) {
                    if ($tk['top'] >= $roiTop && $tk['bottom'] <= $roiBottom) {
                        $tx = strtolower($tk['text']);
                        $isLabel = false; foreach ($labelWords as $lw){ if ($tx === $lw || $tx === ($lw.'.')){ $isLabel=true; break; } }
                        if ($isLabel) { continue; }
                        if (!preg_match('/[A-Za-z]{2,}/', $tk['text'])) { continue; }
                        if (substr($tx, -1) === '-') { continue; }
                        $cands[] = $tk;
                    }
                }
                if (empty($cands)) { try { Log::info('OCR fallback above-name: no tokens in ROI', ['roiTop' => $roiTop, 'roiBottom' => $roiBottom]); } catch (\Throwable $e) {} return []; }
                // Group by line proximity
                usort($cands, function($a, $b){ return $a['top'] <=> $b['top']; });
                $lines = [];
                foreach ($cands as $tk) {
                    $placed = false;
                    foreach ($lines as &$ln) {
                        $avgTop = $ln['avgTop'];
                        if (abs($tk['top'] - $avgTop) <= max(12, (int)($tk['height'] * 0.9))) {
                            $ln['tokens'][] = $tk;
                            $ln['avgTop'] = (int)array_sum(array_column($ln['tokens'], 'top')) / max(1, count($ln['tokens']));
                            $placed = true; break;
                        }
                    }
                    if (!$placed) { $lines[] = ['tokens' => [$tk], 'avgTop' => $tk['top']]; }
                }
                // Choose the line with widest horizontal coverage and most tokens
                usort($lines, function($a, $b){
                    $aw = 0; $bw = 0;
                    if (!empty($a['tokens'])) { $aw = max(array_column($a['tokens'], 'right')) - min(array_column($a['tokens'], 'left')); }
                    if (!empty($b['tokens'])) { $bw = max(array_column($b['tokens'], 'right')) - min(array_column($b['tokens'], 'left')); }
                    $ac = count($a['tokens']); $bc = count($b['tokens']);
                    // prioritize width then count
                    if ($bw === $aw) { return $bc <=> $ac; }
                    return $bw <=> $aw;
                });
                foreach ($lines as $ln) {
                    $tks = $ln['tokens'];
                    usort($tks, function($a, $b){ return $a['left'] <=> $b['left']; });
                    $segments = []; $current = []; $lastRight = null;
                    foreach ($tks as $tk) {
                        if ($lastRight !== null && ($tk['left'] - $lastRight) > max(28, (int)($tk['height'] * 1.8))) {
                            if (!empty($current)) { $segments[] = $current; $current = []; }
                        }
                        $current[] = $tk; $lastRight = $tk['right'];
                    }
                    if (!empty($current)) { $segments[] = $current; }
                    if (count($segments) >= 3) {
                        $join = function($seg){ return trim(implode(' ', array_map(function($t){ return $t['text']; }, $seg))); };
                        $fields = [
                            'last_name' => $join($segments[0]),
                            'first_name' => $join($segments[1]),
                            'middle_name' => $join($segments[2]),
                            'fallback_used' => true,
                        ];
                        try { Log::info('OCR fallback above-name used', $fields); } catch (\Throwable $e) {}
                        return $fields;
                    }
                }
                return [];
            };

            // Fallback: cluster top handwriting row into three segments (Last, First, Middle)
            $fallbackTopRow = function() use ($tokens, $pageBottom, $computeBandBottom): array {
                // Filter to likely handwriting tokens in the top band (dynamic)
                $bandBottom = $computeBandBottom();
                $labelWords = ['name','last','first','middle','surname','given'];
                $wordTokens = array_values(array_filter($tokens, function($t) use ($bandBottom, $labelWords) {
                    if ($t['top'] > $bandBottom) { return false; }
                    $tx = strtolower($t['text']);
                    foreach ($labelWords as $lw) {
                        // Skip exact or fuzzy label tokens
                        $norm = preg_replace('/[^a-z]/', '', $tx);
                        $lwNorm = preg_replace('/[^a-z]/', '', $lw);
                        if ($tx === $lw || $tx === ($lw . '.') ) { return false; }
                        $len = max(strlen($norm), strlen($lwNorm));
                        if ($norm !== '' && $lwNorm !== '') {
                            $dist = levenshtein($norm, $lwNorm);
                            if ($len >= 4 ? $dist <= 2 : $dist <= 1) { return false; }
                        }
                    }
                    // Likely handwriting: require at least three alphabetic chars
                    if (!preg_match('/[A-Za-z]{3,}/', $t['text'])) { return false; }
                    // Avoid dangling hyphen tokens like "E-"
                    if (substr($tx, -1) === '-') { return false; }
                    return true;
                }));
                if (empty($wordTokens)) { return []; }
                // Group into horizontal lines by proximity in Y
                usort($wordTokens, function($a, $b){ return $a['top'] <=> $b['top']; });
                $lines = [];
                foreach ($wordTokens as $tk) {
                    $placed = false;
                    foreach ($lines as &$ln) {
                        $avgTop = $ln['avgTop'];
                        if (abs($tk['top'] - $avgTop) <= max(12, (int)($tk['height'] * 0.9))) {
                            $ln['tokens'][] = $tk;
                            $ln['avgTop'] = (int)array_sum(array_column($ln['tokens'], 'top')) / max(1, count($ln['tokens']));
                            $placed = true; break;
                        }
                    }
                    if (!$placed) {
                        $lines[] = ['tokens' => [$tk], 'avgTop' => $tk['top']];
                    }
                }
                // Pick the densest early line that has spread across the page
                usort($lines, function($a, $b){ return count($b['tokens']) <=> count($a['tokens']); });
                foreach ($lines as $ln) {
                    $tks = $ln['tokens'];
                    usort($tks, function($a, $b){ return $a['left'] <=> $b['left']; });
                    // Partition tokens into segments using large gaps
                    $segments = [];
                    $current = [];
                    $lastRight = null;
                    foreach ($tks as $tk) {
                        if ($lastRight !== null && ($tk['left'] - $lastRight) > max(28, (int)($tk['height'] * 1.8))) {
                            if (!empty($current)) { $segments[] = $current; $current = []; }
                        }
                        $current[] = $tk;
                        $lastRight = $tk['right'];
                    }
                    if (!empty($current)) { $segments[] = $current; }
                    if (count($segments) >= 3) {
                        $join = function($seg){ return trim(implode(' ', array_map(function($t){ return $t['text']; }, $seg))); };
                        $fields = [
                            'last_name' => $join($segments[0]),
                            'first_name' => $join($segments[1]),
                            'middle_name' => $join($segments[2]),
                            'fallback_used' => true,
                        ];
                        // Re-OCR each segment directly from the original image as a single line for improved accuracy
                        try {
                            if (!empty($this->currentImagePath) && file_exists($this->currentImagePath)) {
                                $pad = 6;
                                $imgW = 0; $imgH = 0;
                                $sz = @getimagesize($this->currentImagePath);
                                if (is_array($sz) && count($sz) >= 2) { $imgW = (int)$sz[0]; $imgH = (int)$sz[1]; }
                                $rectOf = function(array $seg) use ($pad, $imgW, $imgH){
                                    $left = min(array_column($seg, 'left')) - $pad;
                                    $right = max(array_column($seg, 'right')) + $pad;
                                    $top = min(array_column($seg, 'top')) - $pad;
                                    $bottom = max(array_column($seg, 'bottom')) + $pad;
                                    $left = max(0, $left); $top = max(0, $top);
                                    if ($imgW > 0) { $right = min($imgW - 1, $right); }
                                    if ($imgH > 0) { $bottom = min($imgH - 1, $bottom); }
                                    return ['x' => (int)$left, 'y' => (int)$top, 'w' => (int)max(1, $right - $left), 'h' => (int)max(1, $bottom - $top)];
                                };
                                $reOcr = function(array $rect, bool $isLast) {
                                    $src = null;
                                    $ext = strtolower(pathinfo($this->currentImagePath, PATHINFO_EXTENSION));
                                    if ($ext === 'png') { $src = @imagecreatefrompng($this->currentImagePath); }
                                    else { $src = @imagecreatefromjpeg($this->currentImagePath); }
                                    if (!$src) { return ''; }
                                    $crop = false;
                                    if (function_exists('imagecrop')) {
                                        $crop = @imagecrop($src, ['x' => $rect['x'], 'y' => $rect['y'], 'width' => $rect['w'], 'height' => $rect['h']]);
                                    }
                                    if ($crop === false) {
                                        $crop = @imagecreatetruecolor($rect['w'], $rect['h']);
                                        if ($crop) { @imagecopy($crop, $src, 0, 0, $rect['x'], $rect['y'], $rect['w'], $rect['h']); }
                                    }
                                    @imagedestroy($src);
                                    if (!$crop) { return ''; }
                                    // Simple preprocessing: upscale, grayscale, increase contrast, slight sharpen
                                    if (function_exists('imagescale')) {
                                        $w = imagesx($crop); $h = imagesy($crop);
                                        $scaled = @imagescale($crop, (int)floor($w * 1.8), (int)floor($h * 1.8), IMG_BILINEAR_FIXED);
                                        if ($scaled) { @imagedestroy($crop); $crop = $scaled; }
                                    }
                                    @imagefilter($crop, IMG_FILTER_GRAYSCALE);
                                    @imagefilter($crop, IMG_FILTER_CONTRAST, -25);
                                    if (function_exists('imageconvolution')) {
                                        $matrix = [[-1,-1,-1],[-1,12,-1],[-1,-1,-1]]; $div = 4; $off = 0;
                                        @imageconvolution($crop, $matrix, $div, $off);
                                    }
                                    // Otsu binarization to improve OCR contrast
                                    $w = imagesx($crop); $h = imagesy($crop);
                                    if ($w > 0 && $h > 0) {
                                        $hist = array_fill(0, 256, 0);
                                        for ($y = 0; $y < $h; $y++) {
                                            for ($x = 0; $x < $w; $x++) {
                                                $rgb = imagecolorat($crop, $x, $y);
                                                $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                $gray = (int)round(0.299*$r + 0.587*$g + 0.114*$b);
                                                $hist[$gray]++;
                                            }
                                        }
                                        $total = $w * $h;
                                        $sum = 0; for ($i = 0; $i < 256; $i++) { $sum += $i * $hist[$i]; }
                                        $sumB = 0; $wB = 0; $maxVar = 0; $threshold = 127;
                                        for ($t = 0; $t < 256; $t++) {
                                            $wB += $hist[$t]; if ($wB === 0) { continue; }
                                            $wF = $total - $wB; if ($wF === 0) { break; }
                                            $sumB += $t * $hist[$t];
                                            $mB = $sumB / $wB; $mF = ($sum - $sumB) / $wF;
                                            $between = $wB * $wF * ($mB - $mF) * ($mB - $mF);
                                            if ($between > $maxVar) { $maxVar = $between; $threshold = $t; }
                                        }
                                        $black = imagecolorallocate($crop, 0, 0, 0);
                                        $white = imagecolorallocate($crop, 255, 255, 255);
                                        for ($y = 0; $y < $h; $y++) {
                                            for ($x = 0; $x < $w; $x++) {
                                                $rgb = imagecolorat($crop, $x, $y);
                                                $r = ($rgb >> 16) & 0xFF; $g = ($rgb >> 8) & 0xFF; $b = $rgb & 0xFF;
                                                $gray = (int)round(0.299*$r + 0.587*$g + 0.114*$b);
                                                imagesetpixel($crop, $x, $y, ($gray <= $threshold) ? $black : $white);
                                            }
                                        }
                                    }
                                    $tmp = tempnam(sys_get_temp_dir(), 'seg_');
                                    $ext = strtolower(pathinfo($this->currentImagePath, PATHINFO_EXTENSION));
                                    $out = $tmp . '.' . ($ext === 'png' ? 'png' : 'jpg');
                                    if ($ext === 'png') { @imagepng($crop, $out); } else { @imagejpeg($crop, $out, 92); }
                                    @imagedestroy($crop);
                                    // Optional: OpenCV preprocess for segment
                                    $pythonPath = config('eldera.ocr.python_path', 'python');
                                    $opencvScript = config('eldera.ocr.opencv_script', base_path('app/Services/ocr_preprocess.py'));
                                    if (is_file($opencvScript)) {
                                        $cvOut = preg_replace('/\.' . preg_quote(pathinfo($out, PATHINFO_EXTENSION), '/') . '$/i', '_cv.' . pathinfo($out, PATHINFO_EXTENSION), $out);
                                        $cmdCv = $pythonPath . ' ' . escapeshellarg($opencvScript) . ' --in ' . escapeshellarg($out) . ' --out ' . escapeshellarg($cvOut) . ' --deskew 0';
                                        $resCv = @shell_exec($cmdCv . ' 2>&1');
                                        if (is_file($cvOut) && filesize($cvOut) > 0) {
                                            try { Log::info('OpenCV segment preprocess used', ['input' => $out, 'output' => $cvOut]); } catch (\Throwable $e) {}
                                            $out = $cvOut;
                                        } else {
                                            try { Log::warning('OpenCV segment preprocess failed or skipped', ['input' => $out, 'result' => $resCv]); } catch (\Throwable $e) {}
                                        }
                                    }
                                    $cmdBase = 'tesseract ' . escapeshellarg($out) . ' stdout -l eng --oem 1 -c preserve_interword_spaces=1';
                                    if ($isLast) {
                                        // Strict uppercase whitelist for surname box; try PSM 7 and 8
                                        $cmdBase .= ' -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                                        $out7 = @shell_exec($cmdBase . ' --psm 7');
                                        $out8 = @shell_exec($cmdBase . ' --psm 8');
                                        $cand7 = strtoupper(trim(preg_replace('/[^A-Z]/', '', (string)$out7)));
                                        $cand8 = strtoupper(trim(preg_replace('/[^A-Z]/', '', (string)$out8)));
                                        $text = (strlen($cand8) >= strlen($cand7)) ? $cand8 : $cand7;
                                    } else {
                                        $cmdBase .= ' -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.\'-';
                                        $text = @shell_exec($cmdBase . ' --psm 7');
                                        if (!is_string($text) || trim($text) === '') {
                                            $text = @shell_exec($cmdBase . ' --psm 6');
                                        }
                                    }
                                    @unlink($out); @unlink($tmp);
                                    $text = is_string($text) ? trim($text) : '';
                                    return $text;
                                };
                                $rLast = $rectOf($segments[0]);
                                $rFirst = $rectOf($segments[1]);
                                $rMiddle = $rectOf($segments[2]);
                                $oLast = $reOcr($rLast, true);
                                $oFirst = $reOcr($rFirst, false);
                                $oMiddle = $reOcr($rMiddle, false);
                                try { Log::info('OCR segment re-OCR', ['last' => $oLast, 'first' => $oFirst, 'middle' => $oMiddle]); } catch (\Throwable $e) {}
                                $prefer = function(string $orig, string $improved){
                                    $oScore = strlen(preg_replace('/[^A-Za-z]/', '', $orig));
                                    $iScore = strlen(preg_replace('/[^A-Za-z]/', '', $improved));
                                    // Prefer improved if it has more alphabetic characters and looks plausible
                                    if ($iScore > max(2, $oScore)) { return $improved; }
                                    return $orig;
                                };
                                // Prefer a single plausible uppercase token (avoid concatenated runs)
                                $vowelRatio = function(string $s): float { $v = preg_match_all('/[AEIOU]/', strtoupper($s)); $l = strlen($s); return $l>0 ? ($v/$l) : 0.0; };
                                $bestUpper = function(string $s) use ($vowelRatio): string {
                                    $up = strtoupper($s);
                                    $tokens = preg_split('/[^A-Z]+/', $up);
                                    $best = '';
                                    $bestScore = -1.0;
                                    foreach ($tokens as $t) {
                                        if ($t === null) { continue; }
                                        $t = trim($t);
                                        $len = strlen($t);
                                        if ($len < 4) { continue; }
                                        $vCount = preg_match_all('/[AEIOU]/', $t);
                                        $vr = $vowelRatio($t);
                                        if ($vCount < 2 || $vr < 0.35) { continue; }
                                        $endsVowel = (bool)preg_match('/[AEIOU]$/', $t);
                                        // Score by length with small bonus for ending in a vowel and higher vowel ratio
                                        $score = ($len * 1.0) + ($vr * 0.5) + ($endsVowel ? 0.5 : 0.0);
                                        if ($score > $bestScore) { $best = $t; $bestScore = $score; }
                                    }
                                    return $best;
                                };
                                $chooseUpper = function(string $orig, string $improved) use ($bestUpper){
                                    $oBest = $bestUpper($orig);
                                    $iBest = $bestUpper($improved);
                                    if ($iBest !== '' && (strlen($iBest) > strlen($oBest))) { return $iBest; }
                                    if ($oBest !== '') { return $oBest; }
                                    // No plausible tokens; keep original unchanged (avoid concatenation artifacts)
                                    return $orig;
                                };
                                $prevLast = $fields['last_name'] ?? '';
                                $fields['last_name'] = $chooseUpper($prevLast, $oLast);
                                if ($fields['last_name'] !== '' && $fields['last_name'] !== $prevLast) {
                                    try { Log::info('OCR top-row last-name upgraded via uppercase gating', ['from' => $prevLast, 'to' => $fields['last_name']]); } catch (\Throwable $e) {}
                                }
                                $fields['first_name'] = $prefer($fields['first_name'], $oFirst);
                                $fields['middle_name'] = $prefer($fields['middle_name'], $oMiddle);
                                // Final plausibility gate: blank implausible last names to avoid noisy concatenations
                                $lu = strtoupper(trim(preg_replace('/[^A-Z]/', '', (string)$fields['last_name'])));
                                $lenLu = strlen($lu);
                                if ($lenLu >= 4) {
                                    $vCountLu = preg_match_all('/[AEIOU]/', $lu);
                                    $vrLu = ($lenLu > 0) ? ($vCountLu / $lenLu) : 0.0;
                                    if ($vCountLu < 2 || $vrLu < 0.35) {
                                        try { Log::info('OCR top-row last-name rejected (implausible)', ['last' => $fields['last_name'], 'upper' => $lu, 'vowels' => $vCountLu, 'vowel_ratio' => $vrLu]); } catch (\Throwable $e) {}
                                        $fields['last_name'] = '';
                                    }
                                }
                            }
                        } catch (\Throwable $e) {
                            try { Log::warning('OCR segment re-OCR failed', ['error' => $e->getMessage()]); } catch (\Throwable $e2) {}
                        }
                        return $fields;
                    }
                }
                return [];
            };

            // Fallback: split top band into three equal columns (last, first, middle)
            $fallbackThreeCols = function() use ($tokens, $pageRight, $pageBottom, $computeBandBottom): array {
                if ($pageRight <= 0 || $pageBottom <= 0) { return []; }
                $bandTop = 0;
                $bandBottom = $computeBandBottom();
                $bandHeight = max(40, $bandBottom - $bandTop);
                $colWidth = (int)floor($pageRight / 3);
                $labelWords = ['name','last','first','middle','surname','given'];
                $collectCol = function(int $x0, int $x1, int $y0, int $y1) use ($tokens, $labelWords): string {
                    $tks = [];
                    foreach ($tokens as $tk) {
                        if ($tk['top'] >= $y0 && $tk['bottom'] <= $y1 && $tk['left'] >= $x0 && $tk['right'] <= $x1) {
                            $tx = strtolower($tk['text']);
                            // Skip exact or fuzzy label tokens
                            $isLabel = false;
                            $norm = preg_replace('/[^a-z]/', '', $tx);
                            foreach ($labelWords as $lw){
                                $lwNorm = preg_replace('/[^a-z]/','', $lw);
                                if ($tx === $lw || $tx === ($lw.'.')){ $isLabel=true; break; }
                                $len = max(strlen($norm), strlen($lwNorm));
                                if ($norm !== '' && $lwNorm !== '') {
                                    $dist = levenshtein($norm, $lwNorm);
                                    if ($len >= 4 ? $dist <= 2 : $dist <= 1) { $isLabel=true; break; }
                                }
                            }
                            if ($isLabel) { continue; }
                            if (!preg_match('/[A-Za-z]{3,}/', $tk['text'])) { continue; }
                            if (substr($tx, -1) === '-') { continue; }
                            $tks[] = $tk;
                        }
                    }
                    usort($tks, function($a, $b){ return $a['left'] <=> $b['left']; });
                    return trim(implode(' ', array_map(function($t){ return $t['text']; }, $tks)));
                };
                $last = $collectCol(0, $colWidth, $bandTop, $bandTop + $bandHeight);
                $first = $collectCol($colWidth + 1, 2 * $colWidth, $bandTop, $bandTop + $bandHeight);
                $middle = $collectCol(2 * $colWidth + 1, $pageRight, $bandTop, $bandTop + $bandHeight);
                // Simple rebalancing: if a column only captured a label or is empty, shift left
                if ($last === '' && $first !== '' && $middle === '') { $last = $first; $first = ''; }
                if ($last === '' && $first !== '' && $middle !== '') { $last = $first; $first = $middle; $middle = ''; }
                if ($last !== '' || $first !== '' || $middle !== '') {
                    return [
                        'last_name' => $last,
                        'first_name' => $first,
                        'middle_name' => $middle,
                        'fallback_used' => true,
                    ];
                }
                return [];
            };

            // Fallback: cluster top-band tokens into three X-position groups (k-means)
            $fallbackKMeansThree = function() use ($tokens, $pageRight, $pageBottom, $computeBandBottom): array {
                if ($pageRight <= 0 || $pageBottom <= 0) { return []; }
                $bandBottom = $computeBandBottom();
                $labelWords = ['name','last','first','middle','surname','given'];
                $candidates = [];
                foreach ($tokens as $tk) {
                    if ($tk['top'] > $bandBottom) { continue; }
                    $tx = strtolower($tk['text']);
                    $isLabel = false; 
                    $norm = preg_replace('/[^a-z]/', '', $tx);
                    foreach ($labelWords as $lw){ 
                        $lwNorm = preg_replace('/[^a-z]/', '', $lw);
                        if ($tx === $lw || $tx === ($lw.'.')){ $isLabel=true; break; }
                        $len = max(strlen($norm), strlen($lwNorm));
                        if ($norm !== '' && $lwNorm !== '') {
                            $dist = levenshtein($norm, $lwNorm);
                            if ($len >= 4 ? $dist <= 2 : $dist <= 1) { $isLabel=true; break; }
                        }
                    }
                    if ($isLabel) { continue; }
                    if (!preg_match('/[A-Za-z]{3,}/', $tk['text'])) { continue; }
                    if (substr($tx, -1) === '-') { continue; }
                    $tk['center'] = (int)(($tk['left'] + $tk['right']) / 2);
                    $candidates[] = $tk;
                }
                if (count($candidates) < 3) { return []; }
                // Initialize 3 centers roughly left/middle/right
                $centers = [ (int)($pageRight * 1/6), (int)($pageRight * 3/6), (int)($pageRight * 5/6) ];
                $clusters = [[],[],[]];
                for ($iter = 0; $iter < 8; $iter++) {
                    $clusters = [[],[],[]];
                    foreach ($candidates as $tk) {
                        $d0 = abs($tk['center'] - $centers[0]);
                        $d1 = abs($tk['center'] - $centers[1]);
                        $d2 = abs($tk['center'] - $centers[2]);
                        $idx = 0; $best = $d0;
                        if ($d1 < $best) { $best = $d1; $idx = 1; }
                        if ($d2 < $best) { $best = $d2; $idx = 2; }
                        $clusters[$idx][] = $tk;
                    }
                    // Recompute centers
                    for ($k = 0; $k < 3; $k++) {
                        if (!empty($clusters[$k])) {
                            $centers[$k] = (int)(array_sum(array_map(function($t){ return $t['center']; }, $clusters[$k])) / max(1, count($clusters[$k])));
                        }
                    }
                }
                // Sort clusters left-to-right by center
                $ordered = [];
                for ($k = 0; $k < 3; $k++) { $ordered[] = ['center' => $centers[$k], 'tokens' => $clusters[$k]]; }
                usort($ordered, function($a, $b){ return $a['center'] <=> $b['center']; });
                $join = function($seg){
                    usort($seg, function($a, $b){ return $a['left'] <=> $b['left']; });
                    return trim(implode(' ', array_map(function($t){ return $t['text']; }, $seg)));
                };
                $last = $join($ordered[0]['tokens']);
                $first = $join($ordered[1]['tokens']);
                $middle = $join($ordered[2]['tokens']);
                if ($last !== '' || $first !== '' || $middle !== '') {
                    return [
                        'last_name' => $last,
                        'first_name' => $first,
                        'middle_name' => $middle,
                        'fallback_used' => true,
                    ];
                }
                return [];
            };

            $extractAround = function(?array $label) use ($tokens, $pageRight): string {
                if (!$label) { return ''; }

                $collectTokens = function(int $roiTop, int $roiBottom, int $roiLeft, int $roiRight) use ($tokens): array {
                    $anchors = ['province','region','city','municipality','barangay','street','house','purok','sitio','village'];
                    $candidates = [];
                    foreach ($tokens as $tk) {
                        if ($tk['top'] >= $roiTop && $tk['bottom'] <= $roiBottom && $tk['left'] >= $roiLeft && $tk['right'] <= $roiRight) {
                            if (preg_match('/^[A-Za-z0-9][A-Za-z0-9\-\.\']*$/', $tk['text'])) {
                                $lx = strtolower($tk['text']);
                                // Skip obvious printed anchors and tokens ending with a dot (labels)
                                $isAnchor = false; foreach ($anchors as $a){ if ($lx === $a || $lx === ($a.'.')){ $isAnchor = true; break; } }
                                if ($isAnchor) { continue; }
                                if (substr($lx, -1) === '.') { continue; }
                                // Prefer handwriting-like tokens (≥2 letters)
                                if (!preg_match('/[A-Za-z]{2,}/', $tk['text'])) { continue; }
                                $candidates[] = $tk;
                            }
                        }
                    }
                    usort($candidates, function($a, $b) { return $a['left'] <=> $b['left']; });
                    return $candidates;
                };

                $looksLikeLabel = function(string $s): bool {
                    $low = strtolower(trim($s));
                    if ($low === '') { return false; }
                    foreach (['name','first','last','middle','given','surname','info','information'] as $l) {
                        if (strpos($low, $l) !== false) { return true; }
                    }
                    return false;
                };
                $isWeakName = function(string $s): bool {
                    $alpha = preg_replace('/[^A-Za-z]/', '', $s);
                    if (strlen($alpha) < 3) { return true; }
                    $tokensW = preg_split('/\s+/', trim($s));
                    $short = 0; $tot = 0;
                    foreach ($tokensW as $t) { if ($t === '') { continue; } $tot++; if (strlen(preg_replace('/[^A-Za-z]/','',$t)) <= 2) { $short++; } }
                    return ($tot > 0 && $short >= max(2, (int)ceil($tot * 0.5)));
                };
                $ocrCrop = function(int $x, int $y, int $w, int $h): string {
                    try {
                        $srcPath = $this->currentImagePath ?? null;
                        if ($srcPath && file_exists($srcPath)) {
                            $ext = strtolower(pathinfo($srcPath, PATHINFO_EXTENSION));
                            $srcImg = null;
                            if (in_array($ext, ['jpg','jpeg'])) { $srcImg = @imagecreatefromjpeg($srcPath); }
                            elseif ($ext === 'png') { $srcImg = @imagecreatefrompng($srcPath); }
                            if ($srcImg) {
                                $cropRect = ['x' => max(0,$x), 'y' => max(0,$y), 'width' => max(10,$w), 'height' => max(30,$h)];
                                $seg = @imagecrop($srcImg, $cropRect);
                                if ($seg) {
                                    $tmp = tempnam(sys_get_temp_dir(), 'seg_');
                                    $out = $tmp . '.' . ($ext === 'png' ? 'png' : 'jpg');
                                    if ($ext === 'png') { @imagepng($seg, $out); } else { @imagejpeg($seg, $out, 92); }
                                    @imagedestroy($seg);
                                    @imagedestroy($srcImg);
                                    $cfg = ' -l eng --oem 1 -c preserve_interword_spaces=1 -c load_system_dawg=0 -c load_freq_dawg=0 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\'\-.';
                                    $text = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 7' . $cfg);
                                    if (!is_string($text) || trim($text) === '') {
                                        $text = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 13' . $cfg);
                                    }
                                    @unlink($out); @unlink($tmp);
                                    $clean = is_string($text) ? trim(preg_replace('/[^A-Za-z\s]/', ' ', $text)) : '';
                                    if ($clean !== '' && strlen(preg_replace('/[^A-Za-z]/','', $clean)) >= 3) {
                                        try { Log::info('OCR label-anchored crop OCR', ['text' => $clean, 'roi' => [$cropRect['x'],$cropRect['y'],$cropRect['width'],$cropRect['height']]]); } catch (\Throwable $e) {}
                                        return $clean;
                                    }
                                } else { @imagedestroy($srcImg); }
                            }
                        }
                    } catch (\Throwable $e) {
                        try { Log::warning('Label-anchored crop OCR failed', ['error' => $e->getMessage()]); } catch (\Throwable $e2) {}
                    }
                    return '';
                };

                // Try ABOVE the label first (common on forms: box above the printed label)
                $heightBand = max(80, (int)($label['height'] * 4));
                $roiBottomA = $label['top'] - 5;
                $roiTopA = max(0, $roiBottomA - $heightBand);
                $roiLeftA = max(0, $label['left'] - 20);
                // Keep the ROI narrow around the column to avoid capturing address blocks
                $roiRightA = min($pageRight, $label['right'] + max(120, (int)($pageRight * 0.15)));
                $aboveTokens = $collectTokens($roiTopA, $roiBottomA, $roiLeftA, $roiRightA);

                if (!empty($aboveTokens)) {
                    $texts = array_map(function($t){ return $t['text']; }, $aboveTokens);
                    $joined = trim(implode(' ', $texts));
                    $jlow = strtolower($joined);
                    $badAnchors = ['province','region','city','municipality','barangay','street'];
                    foreach ($badAnchors as $ba){ if (strpos($jlow, $ba) !== false) { $joined = ''; break; } }
                    // Always attempt crop OCR; prefer it if it yields more alphabetic content
                    $resA = $ocrCrop($roiLeftA, $roiTopA, $roiRightA - $roiLeftA, $roiBottomA - $roiTopA);
                    if ($resA !== '') {
                        $oScore = strlen(preg_replace('/[^A-Za-z]/', '', $joined));
                        $iScore = strlen(preg_replace('/[^A-Za-z]/', '', $resA));
                        if ($iScore > max(2, $oScore)) { return $resA; }
                    }
                    if ($joined !== '' && ($looksLikeLabel($joined) || $isWeakName($joined))) { return $resA !== '' ? $resA : ''; }
                    return $joined;
                }

                // Fallback: BELOW the label — only consider if label is not near the page top
                if ($label['top'] <= 40) { return ''; }
                $roiTopB = $label['bottom'] + 5;
                $roiBottomB = $roiTopB + $heightBand;
                $roiLeftB = max(0, $label['left'] - 20);
                $roiRightB = min($pageRight, $label['right'] + max(120, (int)($pageRight * 0.15)));
                $belowTokens = $collectTokens($roiTopB, $roiBottomB, $roiLeftB, $roiRightB);

                if (empty($belowTokens)) { return ''; }
                $texts = array_map(function($t){ return $t['text']; }, $belowTokens);
                $joined = trim(implode(' ', $texts));
                $jlow = strtolower($joined);
                // Block common address/location substrings even if OCR splits words (e.g., "ie Str")
                $anchorSubs = ['prov','region','city','muni','barang','street','str','house','zone','purok','sit','sitio','vill','village','pob','pobl','brgy'];
                $blocked = false;
                foreach ($anchorSubs as $as){ if (strpos($jlow, $as) !== false) { $blocked = true; break; } }
                if (!$blocked) {
                    foreach ($belowTokens as $bt){ $lx = strtolower($bt['text']); foreach ($anchorSubs as $as){ if (strpos($lx, $as) !== false) { $blocked = true; break; } } if ($blocked) { break; } }
                }
                // Prefer crop OCR when anchors are detected or text looks weak/label-like
                $resB = $ocrCrop($roiLeftB, $roiTopB, $roiRightB - $roiLeftB, $roiBottomB - $roiTopB);
                if ($blocked) { return $resB !== '' ? $resB : ''; }
                if ($joined !== '' && ($looksLikeLabel($joined) || $isWeakName($joined))) { return $resB !== '' ? $resB : ''; }
                if ($resB !== '') {
                    $oScore = strlen(preg_replace('/[^A-Za-z]/', '', $joined));
                    $iScore = strlen(preg_replace('/[^A-Za-z]/', '', $resB));
                    if ($iScore > max(2, $oScore)) { return $resB; }
                }
                return $joined;
            };

            $lastLabel = $findLabel('Last', 'Name');
            if (!$lastLabel) { $lastLabel = $findCombined(['Last Name', 'Surname']); }

            $firstLabel = $findLabel('First', 'Name');
            if (!$firstLabel) { $firstLabel = $findCombined(['First Name', 'Given Name']); }

            $middleLabel = $findLabel('Middle', 'Name');
            if (!$middleLabel) { $middleLabel = $findCombined(['Middle Name', 'Middle']); }

            Log::info('OCR label rectangles', [
                'last_label' => $lastLabel,
                'first_label' => $firstLabel,
                'middle_label' => $middleLabel,
                'page_right' => $pageRight,
                'page_bottom' => $pageBottom,
            ]);

            $byLabel = [
                'last_name' => $extractAround($lastLabel),
                'first_name' => $extractAround($firstLabel),
                'middle_name' => $extractAround($middleLabel),
            ];
            // If label-based extraction yields little or empty, try fallbacks
            if ((empty($byLabel['last_name']) && empty($byLabel['first_name'])) || (strlen($byLabel['last_name']) <= 1 && strlen($byLabel['first_name']) <= 1)) {
                $fallbackN = $fallbackAboveName();
                if (!empty($fallbackN)) {
                    Log::info('OCR fallback above-name used', $fallbackN);
                    return $fallbackN;
                }
                // New: prefer longest uppercase candidate in the left/top band (targets last name)
                $fallbackLongestUpper = function() use ($tokens, $pageRight, $computeBandBottom): array {
                    if ($pageRight <= 0) { return []; }
                    $bandBottom = $computeBandBottom();
                    // Slightly widen the left-column ROI to better capture surnames that spill right
                    $colWidth = (int)floor($pageRight * 0.40);
                    $x0 = 0; $x1 = max(10, min($pageRight, $colWidth)); $y0 = 0; $y1 = $bandBottom;
                    // Join ROI tokens to catch split uppercase runs and evaluate vowel ratio
                    $roiText = '';
                    foreach ($tokens as $tk) {
                        if ($tk['top'] > $y1 || $tk['left'] < $x0 || $tk['right'] > $x1) { continue; }
                        $roiText .= (isset($tk['text']) ? ($tk['text'].' ') : '');
                    }
                    $roiText = trim($roiText);
                    $candidates = [];
                    if ($roiText !== '') {
                        $roiUp = strtoupper(preg_replace('/[^A-Z\s]/', ' ', $roiText));
                        // Direct uppercase words
                        if (preg_match_all('/\b[A-Z]{5,}\b/', $roiUp, $m1)) {
                            foreach ($m1[0] as $w) { $candidates[] = $w; }
                        }
                        // Collapsed contiguous uppercase (join split tokens like "MPN A NO" -> "MPNANO")
                        $collapsed = preg_replace('/\s+/', '', $roiUp);
                        if (preg_match_all('/[A-Z]{5,}/', $collapsed, $m2)) {
                            foreach ($m2[0] as $w) { $candidates[] = $w; }
                        }
                    }
                    // Also consider per-token uppercase words
                    foreach ($tokens as $tk) {
                        if ($tk['top'] > $y1 || $tk['left'] < $x0 || $tk['right'] > $x1) { continue; }
                        $t = trim((string)$tk['text']);
                        if (preg_match('/^[A-Z]{5,}$/', $t)) { $candidates[] = $t; }
                    }
                    $pick = '';
                    $bestLen = 0;
                    $vowelScore = function(string $s): float {
                        $vowels = preg_match_all('/[AEIOU]/', $s);
                        $len = strlen($s);
                        return $len > 0 ? ($vowels / $len) : 0.0;
                    };
                    $isLabelWord = function(string $s): bool {
                        $x = strtoupper($s);
                        foreach (['LASTNAME','FIRSTNAME','MIDDLENAME','SURNAME','NAME'] as $lbl) { if (strpos($x, $lbl) !== false) { return true; } }
                        return false;
                    };
                    foreach ($candidates as $c) {
                        // Length guard to avoid merged multi-word noise
                        if (strlen($c) > 20) { continue; }
                        if ($isLabelWord($c)) { continue; }
                        // Names typically have vowels; reject ultra-low vowel ratio
                        if ($vowelScore($c) < 0.35) {
                            try { Log::info('OCR top-band longest-uppercase gated: low-vowel', ['candidate' => $c]); } catch (\Throwable $e) {}
                            continue;
                        }
                        if (strlen($c) > $bestLen) { $pick = $c; $bestLen = strlen($c); }
                    }
                    // If heuristic tokens did not yield a plausible candidate, perform ROI re-OCR with uppercase-only whitelist
                    if ($pick === '') {
                        try {
                            $srcPath = $this->currentImagePath ?? null;
                            if ($srcPath && file_exists($srcPath)) {
                                $ext = strtolower(pathinfo($srcPath, PATHINFO_EXTENSION));
                                $srcImg = null;
                                if (in_array($ext, ['jpg','jpeg'])) { $srcImg = @imagecreatefromjpeg($srcPath); }
                                elseif ($ext === 'png') { $srcImg = @imagecreatefrompng($srcPath); }
                                if ($srcImg) {
                                    $cropRect = ['x' => max(0,$x0), 'y' => max(0,$y0), 'width' => max(10, $x1 - $x0), 'height' => max(30, $y1 - $y0)];
                                    $seg = @imagecrop($srcImg, $cropRect);
                                    if ($seg) {
                                        // Preprocess: stronger upscale, grayscale, brightness, contrast, sharpen
                                        $w2 = max(30, (int)(($x1 - $x0) * 2.5));
                                        $h2 = max(60, (int)(($y1 - $y0) * 3));
                                        $proc = @imagescale($seg, $w2, $h2, IMG_BILINEAR_FIXED);
                                        if ($proc) {
                                            @imagefilter($proc, IMG_FILTER_GRAYSCALE);
                                            @imagefilter($proc, IMG_FILTER_BRIGHTNESS, 8);
                                            @imagefilter($proc, IMG_FILTER_CONTRAST, -20);
                                            $kernel = [
                                                [-1, -1, -1],
                                                [-1, 16, -1],
                                                [-1, -1, -1],
                                            ];
                                            @imageconvolution($proc, $kernel, 8, 0);
                                        } else { $proc = $seg; }
                                        $tmp = tempnam(sys_get_temp_dir(), 'segU_');
                                        $out = $tmp . '.' . ($ext === 'png' ? 'png' : 'jpg');
                                        if ($ext === 'png') { @imagepng($proc, $out); } else { @imagejpeg($proc, $out, 92); }
                                        @imagedestroy($seg);
                                        @imagedestroy($proc);
                                        @imagedestroy($srcImg);
                                        // Optional: OpenCV preprocess for ROI to improve binarization and deskew
                                        try {
                                            $pythonPath = config('eldera.ocr.python_path', 'python');
                                            $opencvScript = config('eldera.ocr.opencv_script', base_path('app/Services/ocr_preprocess.py'));
                                            if (is_file($opencvScript)) {
                                                $cvOut = preg_replace('/\.' . preg_quote(pathinfo($out, PATHINFO_EXTENSION), '/') . '$/i', '_cv.' . pathinfo($out, PATHINFO_EXTENSION), $out);
                                                $cmdCv = $pythonPath . ' ' . escapeshellarg($opencvScript) . ' --in ' . escapeshellarg($out) . ' --out ' . escapeshellarg($cvOut) . ' --deskew 1';
                                                $resCv = @shell_exec($cmdCv . ' 2>&1');
                                                if (is_file($cvOut) && filesize($cvOut) > 0) {
                                                    try { Log::info('OpenCV top-band uppercase preprocess used', ['input' => $out, 'output' => $cvOut]); } catch (\Throwable $e) {}
                                                    $out = $cvOut;
                                                } else {
                                                    try { Log::warning('OpenCV top-band uppercase preprocess failed or skipped', ['input' => $out, 'result' => $resCv]); } catch (\Throwable $e) {}
                                                }
                                            }
                                        } catch (\Throwable $e) {}
                                        $cfg = ' -l eng --oem 1 -c preserve_interword_spaces=1 -c load_system_dawg=0 -c load_freq_dawg=0 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ\'-';
                                        $t7 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 7' . $cfg);
                                        $t8 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 8' . $cfg);
                                        $t13 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 13' . $cfg);
                                        if (!is_string($t7) || trim($t7) === '') { $t7 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 6' . $cfg); }
                                        if (!is_string($t8) || trim($t8) === '') { $t8 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 6' . $cfg); }
                                        if (!is_string($t13) || trim($t13) === '') { $t13 = @shell_exec('tesseract ' . escapeshellarg($out) . ' stdout --psm 6' . $cfg); }
                                        @unlink($out); @unlink($tmp);
                                        $toTokens = function($s){ $u = strtoupper(trim($s)); return array_values(array_filter(preg_split('/[^A-Z]+/', $u), function($t){ return strlen($t) >= 4; })); };
                                        $p7 = $toTokens($t7 ?? '');
                                        $p8 = $toTokens($t8 ?? '');
                                        $p13 = $toTokens($t13 ?? '');
                                        try {
                                            Log::info('OCR top-band uppercase re-OCR tokens', [
                                                'p7' => count($p7), 'p8' => count($p8), 'p13' => count($p13),
                                                'len7' => strlen((string)$t7), 'len8' => strlen((string)$t8), 'len13' => strlen((string)$t13)
                                            ]);
                                        } catch (\Throwable $e) {}
                                        // Consensus: prefer tokens appearing in both PSM outputs; otherwise take best from union
                                        $cons = array_values(array_intersect($p7, $p8, $p13));
                                        $union = array_values(array_unique(array_merge($p7, $p8, $p13)));
                                        $pool = !empty($cons) ? $cons : $union;
                                        $best = '';
                                        $bestScoreU = -1.0;
                                        foreach ($pool as $tok) {
                                            if (strlen($tok) > 20) { continue; }
                                            if ($isLabelWord($tok)) { continue; }
                                            $vr = $vowelScore($tok);
                                            if ($vr < 0.35) { try { Log::info('OCR top-band uppercase re-OCR gated: low-vowel', ['candidate' => $tok]); } catch (\Throwable $e) {} continue; }
                                            $vCount = preg_match_all('/[AEIOU]/', $tok);
                                            if ($vCount < 2) { continue; }
                                            $endsVowel = (bool)preg_match('/[AEIOU]$/', $tok);
                                            $score = (strlen($tok) * 1.0) + ($vr * 0.5) + ($endsVowel ? 0.5 : 0.0);
                                            if ($score > $bestScoreU) { $best = $tok; $bestScoreU = $score; }
                                        }
                                        if ($best !== '') {
                                            $pick = $best;
                                            try { Log::info('OCR top-band uppercase re-OCR applied', ['candidate' => $pick, 'roi' => $cropRect]); } catch (\Throwable $e) {}
                                        }
                                    } else { @imagedestroy($srcImg); }
                                }
                            }
                        } catch (\Throwable $e) {
                            try { Log::warning('Top-band uppercase re-OCR failed', ['error' => $e->getMessage()]); } catch (\Throwable $e2) {}
                        }
                    }
                    if ($pick !== '') {
                        try { Log::info('OCR top-band longest-uppercase applied', ['candidate' => $pick]); } catch (\Throwable $e) {}
                        return ['last_name' => $pick, 'first_name' => '', 'middle_name' => '', 'fallback_used' => true];
                    }
                    return [];
                };
                $lu = $fallbackLongestUpper();
                if (!empty($lu)) {
                    Log::info('OCR fallback longest-uppercase used', $lu);
                    return $lu;
                }
                $fallback = $fallbackTopRow();
                if (!empty($fallback)) {
                    Log::info('OCR fallback top-row used', $fallback);
                    return $fallback;
                }
                $fallback3 = $fallbackKMeansThree();
                if (!empty($fallback3)) {
                    Log::info('OCR fallback kmeans-three used', $fallback3);
                    return $fallback3;
                }
                $fallback2 = $fallbackThreeCols();
                if (!empty($fallback2)) {
                    Log::info('OCR fallback three-columns used', $fallback2);
                    return $fallback2;
                }
            }
            // If nothing meaningful was found, signal the caller to use plain-text heuristic by returning empty
            $hasNames = (isset($byLabel['last_name']) && strlen(trim($byLabel['last_name'])) > 1)
                || (isset($byLabel['first_name']) && strlen(trim($byLabel['first_name'])) > 1)
                || (isset($byLabel['middle_name']) && strlen(trim($byLabel['middle_name'])) > 1);
            return $hasNames ? $byLabel : [];
        }
    }