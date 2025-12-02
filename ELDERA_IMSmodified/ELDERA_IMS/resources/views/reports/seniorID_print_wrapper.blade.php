<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title ?? 'Senior ID Card' }}</title>
    <style>
        @page { size: A4 portrait; margin: 8mm; }
        body { font-family: Arial, sans-serif; color: #000; }
        .print-actions { margin-bottom: 12px; }
        .print-actions button { padding: 8px 12px; background: #e31575; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        .cards-grid { display: grid; grid-template-columns: 1fr; gap: 12px; justify-items: center; }
        .card-container { display: flex; justify-content: center; align-items: center; }
        .card { width: 1011px; height: 638px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        
        @media print {
            .print-actions { display: none; }
            body { margin: 0; display: grid; place-items: center; }
            .cards-grid { --scale: 0.60; justify-items: center; }
            .card { width: calc(1011px * var(--scale)); height: calc(638px * var(--scale)); }
            .card .card-html { transform: scale(var(--scale)); transform-origin: top left; }
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
