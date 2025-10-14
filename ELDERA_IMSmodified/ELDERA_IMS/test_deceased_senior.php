<?php

require_once 'vendor/autoload.php';

// Load Laravel app
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Senior;

echo "=== TESTING DECEASED SENIOR FUNCTIONALITY ===\n\n";

// Check if we already have a deceased senior
$deceasedSenior = Senior::where('status', 'deceased')->first();

if ($deceasedSenior) {
    echo "Found existing deceased senior:\n";
    echo "ID: {$deceasedSenior->id}\n";
    echo "Name: {$deceasedSenior->first_name} {$deceasedSenior->last_name}\n";
    echo "OSCA ID: {$deceasedSenior->osca_id}\n";
    echo "Status: {$deceasedSenior->status}\n";
    echo "Has App Account: " . ($deceasedSenior->has_app_account ? 'Yes' : 'No') . "\n\n";
} else {
    echo "No deceased senior found. Creating one for testing...\n";
    
    // Find an active senior to mark as deceased
    $activeSenior = Senior::where('status', 'active')->where('has_app_account', false)->first();
    
    if ($activeSenior) {
        echo "Marking senior {$activeSenior->first_name} {$activeSenior->last_name} as deceased...\n";
        $activeSenior->status = 'deceased';
        $activeSenior->save();
        
        echo "✓ Senior marked as deceased:\n";
        echo "ID: {$activeSenior->id}\n";
        echo "Name: {$activeSenior->first_name} {$activeSenior->last_name}\n";
        echo "OSCA ID: {$activeSenior->osca_id}\n";
        echo "Status: {$activeSenior->status}\n";
        echo "Has App Account: " . ($activeSenior->has_app_account ? 'Yes' : 'No') . "\n\n";
    } else {
        echo "No suitable active senior found to mark as deceased.\n";
    }
}

// Show all seniors with their status
echo "=== ALL SENIORS STATUS SUMMARY ===\n";
$seniors = Senior::select('id', 'first_name', 'last_name', 'osca_id', 'status', 'has_app_account')->get();

foreach ($seniors as $senior) {
    $statusIcon = $senior->status === 'deceased' ? '💀' : '✅';
    $appAccountIcon = $senior->has_app_account ? '📱' : '❌';
    echo "{$statusIcon} {$senior->first_name} {$senior->last_name} ({$senior->osca_id}) - Status: {$senior->status} - App Account: {$appAccountIcon}\n";
}

echo "\nDone. You can now test the disabled button functionality in the web interface.\n";