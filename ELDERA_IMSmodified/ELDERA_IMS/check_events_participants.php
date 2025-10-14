<?php

require_once 'vendor/autoload.php';

// Load environment variables
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

// Database configuration
$host = $_ENV['DB_HOST'] ?? 'localhost';
$port = $_ENV['DB_PORT'] ?? '5432';
$dbname = $_ENV['DB_DATABASE'] ?? 'eldera_ims';
$username = $_ENV['DB_USERNAME'] ?? 'postgres';
$password = $_ENV['DB_PASSWORD'] ?? '';

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "=== EVENTS TABLE ===\n";
    $stmt = $pdo->query("SELECT id, title, event_date, event_type FROM events ORDER BY event_date DESC LIMIT 5");
    $events = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($events as $event) {
        echo "Event ID: {$event['id']}, Title: {$event['title']}, Date: {$event['event_date']}, Type: {$event['event_type']}\n";
    }
    
    echo "\n=== EVENT_PARTICIPANT TABLE ===\n";
    $stmt = $pdo->query("SELECT event_id, senior_id, attended, registered_at, attendance_notes FROM event_participant ORDER BY event_id, senior_id LIMIT 10");
    $participants = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($participants)) {
        echo "No participants found in event_participant table\n";
    } else {
        foreach ($participants as $participant) {
            $attended = $participant['attended'] ? 'YES' : 'NO';
            echo "Event: {$participant['event_id']}, Senior: {$participant['senior_id']}, Attended: $attended, Registered: {$participant['registered_at']}\n";
        }
    }
    
    echo "\n=== SENIORS TABLE (first 5) ===\n";
    $stmt = $pdo->query("SELECT id, osca_id, first_name, last_name FROM seniors ORDER BY id LIMIT 5");
    $seniors = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($seniors as $senior) {
        echo "Senior ID: {$senior['id']}, OSCA ID: {$senior['osca_id']}, Name: {$senior['first_name']} {$senior['last_name']}\n";
    }
    
    echo "\n=== CHECK SPECIFIC SENIOR (ID 6) PARTICIPATION ===\n";
    $stmt = $pdo->prepare("SELECT ep.*, e.title, e.event_date FROM event_participant ep JOIN events e ON ep.event_id = e.id WHERE ep.senior_id = ?");
    $stmt->execute([6]);
    $seniorParticipation = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (empty($seniorParticipation)) {
        echo "Senior ID 6 has no event participation records\n";
    } else {
        foreach ($seniorParticipation as $participation) {
            $attended = $participation['attended'] ? 'YES' : 'NO';
            echo "Event: {$participation['title']} ({$participation['event_date']}), Attended: $attended\n";
        }
    }
    
} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}