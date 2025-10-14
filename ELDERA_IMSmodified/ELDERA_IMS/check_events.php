<?php

require 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

$events = App\Models\Event::select('id', 'title', 'event_date')->orderBy('event_date')->get();

echo "All events in database:\n";
echo "======================\n";

foreach($events as $e) {
    echo $e->id . ': ' . $e->title . ' - ' . $e->event_date . "\n";
}

echo "\nToday's date: " . date('Y-m-d') . "\n";
echo "60 days from now: " . date('Y-m-d', strtotime('+60 days')) . "\n";