<?php

require_once 'vendor/autoload.php';

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "=== ADDING TEST PARTICIPATION FOR SENIOR 6 ===\n\n";

// Get Senior 6
$senior = \App\Models\Senior::find(6);
if (!$senior) {
    echo "Senior 6 not found!\n";
    exit(1);
}

echo "Senior: {$senior->first_name} {$senior->last_name} (OSCA: {$senior->osca_id})\n\n";

// Get some events to add participation to
$events = \App\Models\Event::orderBy('event_date', 'desc')->limit(3)->get();

foreach ($events as $event) {
    echo "Adding participation to Event: {$event->title} ({$event->event_date})\n";
    
    // Check if already participating
    $existingParticipation = $event->participants()->where('senior_id', $senior->id)->exists();
    
    if ($existingParticipation) {
        echo "  - Already participating in this event\n";
    } else {
        // Add participation with random attendance status
        $attended = rand(0, 1) == 1; // Random true/false
        $attendanceNotes = $attended ? 'Present and engaged' : 'Absent - family emergency';
        
        $event->participants()->attach($senior->id, [
            'attended' => $attended,
            'registered_at' => now(),
            'attendance_notes' => $attendanceNotes
        ]);
        
        $attendedText = $attended ? 'YES' : 'NO';
        echo "  - Added with attendance: $attendedText\n";
        
        // Update event participant count
        $event->current_participants = $event->participants()->count();
        $event->save();
    }
}

echo "\n=== VERIFICATION ===\n";
// Verify the participation was added
$participations = \App\Models\Event::whereHas('participants', function($query) use ($senior) {
    $query->where('senior_id', $senior->id);
})->with(['participants' => function($query) use ($senior) {
    $query->where('senior_id', $senior->id);
}])->get();

foreach ($participations as $event) {
    $participant = $event->participants->first();
    $attended = $participant->pivot->attended ? 'YES' : 'NO';
    $notes = $participant->pivot->attendance_notes ?: 'No notes';
    echo "Event: {$event->title} - Attended: $attended - Notes: $notes\n";
}

echo "\nTest participation data added successfully!\n";