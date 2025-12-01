<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title ?? 'Senior ID Card' }}</title>
    <style>
        @page { size: A4; margin: 12mm; }
        body { font-family: Arial, sans-serif; color: #000; }
        .print-actions { margin-bottom: 12px; }
        .print-actions button { padding: 8px 12px; background: #e31575; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        .cards-grid { display: grid; grid-template-columns: 1fr; gap: 16px; }
        .card-container { display: flex; justify-content: center; }
        .card { width: 1011px; height: 638px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        .note { font-size: 12px; color: #555; margin-top: 8px; }
        @media print {
            .print-actions { display: none; }
            body { margin: 0; }
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
    <p class="note">Tip: For PVC printers, use the per-side preview route to export exact-size artwork.</p>
</body>
</html>

