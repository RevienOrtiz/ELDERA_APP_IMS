<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title ?? 'Senior ID Card' }}</title>
    <style>
        @page { size: A4 portrait; margin: 5mm; }
        body { 
            font-family: Arial, sans-serif; 
            color: #000; 
            -webkit-print-color-adjust: exact; 
            print-color-adjust: exact;
        }
        .print-actions { margin-bottom: 12px; text-align: center; }
        .print-actions button { padding: 10px 20px; background: #e31575; color: #fff; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; font-weight: bold; }
        .print-actions button:hover { background: #c51265; }
        
        .cards-grid { display: grid; grid-template-columns: 1fr; gap: 20px; justify-items: center; padding: 20px; }
        .card-container { display: flex; justify-content: center; align-items: center; }
        .card { width: 1011px; height: 638px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        
        @media print {
            .print-actions { display: none; }
            body { margin: 0; background: white; }
            .cards-grid { 
                /* Scale to fit A4 width (approx 210mm) with margins */
                /* 1011px is wide. Let's maximize it for A4 portrait width */
                --scale: 0.76; 
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 10px;
                padding: 0;
                margin-top: 10px;
            }
            .card-container {
                page-break-inside: avoid;
                margin-bottom: 10px;
            }
            .card { 
                width: calc(1011px * var(--scale)); 
                height: calc(638px * var(--scale)); 
                box-shadow: none;
                border: none;
            }
            .card .card-html { 
                transform: scale(var(--scale)); 
                transform-origin: top left; 
            }
        }
    </style>
</head>
<body>
    <div class="print-actions">
        <button onclick="window.print()">Print</button>
    </div>
    <div class="cards-grid">
        <div class="card-container">
            <div class="card">{!! $frontHtml !!}</div>
        </div>
        <div class="card-container">
            <div class="card">{!! $backHtml !!}</div>
        </div>
    </div>
</body>
</html>
