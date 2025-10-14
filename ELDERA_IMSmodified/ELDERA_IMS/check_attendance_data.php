<?php

require_once 'vendor/autoload.php';

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== CHECKING ATTENDANCE DATA ===\n\n";

// Check events count
$eventsCount = \App\Models\Event::count();
echo "Total Events: $eventsCount\n";

// Check seniors count
$seniorsCount = \App\Models\Senior::count();
echo "Total Seniors: $seniorsCount\n";

// Check if senior 6 exists
$senior = \App\Models\Senior::find(6);
if ($senior) {
    echo "Senior 6: {$senior->first_name} {$senior->last_name} (OSCA: {$senior->osca_id})\n";
} else {
    echo "Senior 6 not found\n";
}

echo "\n=== EVENTS WITH PARTICIPANTS ===\n";
$events = \App\Models\Event::with('participants')->get();

foreach ($events as $event) {
    $participantCount = $event->participants->count();
    echo "Event: {$event->title} ({$event->event_date}) - {$participantCount} participants\n";
    
    if ($participantCount > 0) {
        foreach ($event->participants as $participant) {
            $attended = $participant->pivot->attended ? 'YES' : 'NO';
            echo "  - {$participant->first_name} {$participant->last_name} (ID: {$participant->id}) - Attended: $attended\n";
        }
    }
}

echo "\n=== SENIOR 6 PARTICIPATION ===\n";
if ($senior) {
    $participations = \App\Models\Event::whereHas('participants', function($query) {
        $query->where('senior_id', 6);
    })->with(['participants' => function($query) {
        $query->where('senior_id', 6);
    }])->get();
    
    if ($participations->count() > 0) {
        foreach ($participations as $event) {
            $participant = $event->participants->first();
            $attended = $participant->pivot->attended ? 'YES' : 'NO';
            echo "Event: {$event->title} ({$event->event_date}) - Attended: $attended\n";
        }
    } else {
        echo "Senior 6 has no event participations\n";
    }
}