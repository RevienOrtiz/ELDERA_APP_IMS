<?php

echo "=== TESTING ATTENDANCE API ===\n\n";

$url = "http://127.0.0.1:8000/api/events/attendance/user?senior_id=6";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'Accept: application/json'
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "HTTP Status Code: $httpCode\n";
echo "Response:\n";

if ($response) {
    $data = json_decode($response, true);
    if ($data) {
        echo json_encode($data, JSON_PRETTY_PRINT) . "\n";
        
        if (isset($data['data']['attendance_records'])) {
            echo "\n=== ATTENDANCE RECORDS SUMMARY ===\n";
            foreach ($data['data']['attendance_records'] as $record) {
                $attended = $record['attended'] ? 'YES' : 'NO';
                echo "Event: {$record['event_title']} ({$record['event_date']}) - Attended: $attended\n";
                if (isset($record['attendance_notes'])) {
                    echo "  Notes: {$record['attendance_notes']}\n";
                }
            }
            
            if (isset($data['data']['statistics'])) {
                $stats = $data['data']['statistics'];
                echo "\n=== STATISTICS ===\n";
                echo "Total Events: {$stats['total']}\n";
                echo "Attended: {$stats['attended']}\n";
                echo "Missed: {$stats['missed']}\n";
                echo "Attendance Rate: {$stats['attendance_rate']}%\n";
            }
        }
    } else {
        echo "Failed to decode JSON response\n";
        echo "Raw response: $response\n";
    }
} else {
    echo "No response received\n";
}