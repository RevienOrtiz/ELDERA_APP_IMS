#!/usr/bin/env python3
import argparse
import sys
import os
import cv2
import numpy as np


def read_image(path: str) -> np.ndarray:
    try:
        data = np.fromfile(path, dtype=np.uint8)
        img = cv2.imdecode(data, cv2.IMREAD_COLOR)
        return img
    except Exception:
        return cv2.imread(path, cv2.IMREAD_COLOR)


def write_image(path: str, img: np.ndarray) -> bool:
    try:
        ext = os.path.splitext(path)[1].lower() or '.png'
        flag = cv2.IMWRITE_PNG_COMPRESSION if ext == '.png' else cv2.IMWRITE_JPEG_QUALITY
        params = [flag, 3] if ext == '.png' else [flag, 92]
        ok, buf = cv2.imencode(ext, img, params)
        if not ok:
            return False
        with open(path, 'wb') as f:
            buf.tofile(f)
        return True
    except Exception:
        return False


def light_deskew(gray: np.ndarray) -> np.ndarray:
    # Estimate skew angle using Hough transform; only apply small corrections
    edges = cv2.Canny(gray, 60, 120)
    lines = cv2.HoughLines(edges, 1, np.pi / 180, threshold=120)
    if lines is None:
        return gray
    angles = []
    for rho_theta in lines[:50]:
        rho, theta = rho_theta[0]
        angle = (theta * 180.0 / np.pi) % 180
        # Favor near-horizontal and near-vertical lines
        if 85 <= angle <= 95 or angle <= 5 or angle >= 175:
            angles.append(angle)
    if not angles:
        return gray
    # Convert to rotation relative to horizontal
    # Normalize angles near 90 to 0
    norm = []
    for a in angles:
        if 85 <= a <= 95:
            norm.append(a - 90)
        elif a >= 175:
            norm.append(a - 180)
        else:
            norm.append(a)
    rot = float(np.median(norm))
    if abs(rot) < 0.5:
        return gray
    h, w = gray.shape[:2]
    M = cv2.getRotationMatrix2D((w / 2, h / 2), rot, 1.0)
    return cv2.warpAffine(gray, M, (w, h), flags=cv2.INTER_LINEAR, borderMode=cv2.BORDER_REPLICATE)


def orientation_score(gray: np.ndarray) -> tuple:
    """
    Compute counts of near-horizontal vs near-vertical lines using Hough transform.
    Returns (horizontal_count, vertical_count).
    """
    edges = cv2.Canny(gray, 60, 120)
    lines = cv2.HoughLines(edges, 1, np.pi / 180, threshold=120)
    if lines is None:
        return (0, 0)
    h_count, v_count = 0, 0
    for rho_theta in lines[:100]:
        rho, theta = rho_theta[0]
        angle = (theta * 180.0 / np.pi) % 180
        if angle <= 5 or angle >= 175:
            h_count += 1
        elif 85 <= angle <= 95:
            v_count += 1
    return (h_count, v_count)


def auto_rotate_90(gray: np.ndarray) -> np.ndarray:
    """
    If vertical lines dominate over horizontal ones, try 90° rotations and
    choose the orientation with the most horizontal lines.
    """
    h0, v0 = orientation_score(gray)
    # Only consider rotation when vertical is significantly stronger
    if v0 <= max(8, int(h0 * 1.5)):
        return gray
    rot_cw = cv2.rotate(gray, cv2.ROTATE_90_CLOCKWISE)
    rot_ccw = cv2.rotate(gray, cv2.ROTATE_90_COUNTERCLOCKWISE)
    h_cw, v_cw = orientation_score(rot_cw)
    h_ccw, v_ccw = orientation_score(rot_ccw)
    # Pick the orientation with maximum horizontal line evidence
    best = gray
    best_h = h0
    if h_cw > best_h:
        best = rot_cw
        best_h = h_cw
    if h_ccw > best_h:
        best = rot_ccw
        best_h = h_ccw
    return best


def remove_lines(binary: np.ndarray) -> np.ndarray:
    h, w = binary.shape[:2]
    # Detect horizontal lines
    h_size = max(15, w // 18)
    h_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (h_size, 1))
    h_lines = cv2.morphologyEx(binary, cv2.MORPH_OPEN, h_kernel)
    # Detect vertical lines
    v_size = max(12, h // 24)
    v_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (1, v_size))
    v_lines = cv2.morphologyEx(binary, cv2.MORPH_OPEN, v_kernel)
    # Subtract lines from binary
    no_lines = cv2.subtract(binary, cv2.bitwise_or(h_lines, v_lines))
    return no_lines


def preprocess(img: np.ndarray, deskew: bool) -> np.ndarray:
    if img is None:
        return img
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # Gentle denoise; preserve strokes
    gray = cv2.medianBlur(gray, 3)
    if deskew:
        # First ensure upright orientation when the form is scanned sideways
        gray = auto_rotate_90(gray)
        # Then apply small-angle deskew for fine correction
        gray = light_deskew(gray)
    # Adaptive threshold to isolate handwriting
    bin_img = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_MEAN_C,
                                    cv2.THRESH_BINARY_INV, 25, 12)
    # Remove long ruler/form lines
    bin_img = remove_lines(bin_img)
    # Slight dilation to connect strokes
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (2, 2))
    bin_img = cv2.dilate(bin_img, kernel, iterations=1)
    # Return inverted binary (black text on white) for Tesseract
    out = cv2.bitwise_not(bin_img)
    return out


def main():
    ap = argparse.ArgumentParser(description='OpenCV preprocess for ELDERA OCR')
    ap.add_argument('--in', dest='inp', required=True, help='Input image path')
    ap.add_argument('--out', dest='out', required=True, help='Output image path')
    ap.add_argument('--deskew', type=int, default=1, help='Apply light deskew (0/1)')
    args = ap.parse_args()

    img = read_image(args.inp)
    if img is None:
        print('Failed to read input', file=sys.stderr)
        sys.exit(2)
    out = preprocess(img, bool(args.deskew))
    ok = write_image(args.out, out)
    if not ok:
        print('Failed to write output', file=sys.stderr)
        sys.exit(3)


if __name__ == '__main__':
    main()