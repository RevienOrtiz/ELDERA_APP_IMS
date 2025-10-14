<?php

require_once 'vendor/autoload.php';

// Load Laravel app
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\Senior;
use App\Models\AppUser;

echo "=== DEBUGGING SENIOR APP ACCOUNTS ===\n\n";

// Get all seniors with has_app_account = true
$seniorsWithAccounts = Senior::where('has_app_account', true)->get();
echo "Seniors marked as having app accounts: " . $seniorsWithAccounts->count() . "\n\n";

foreach ($seniorsWithAccounts as $senior) {
    echo "Senior ID: {$senior->id}\n";
    echo "OSCA ID: {$senior->osca_id}\n";
    echo "Name: {$senior->first_name} {$senior->last_name}\n";
    echo "has_app_account: " . ($senior->has_app_account ? 'true' : 'false') . "\n";
    echo "user_id: " . ($senior->user_id ?? 'null') . "\n";
    
    // Check if AppUser exists
    $appUser = AppUser::where('osca_id', $senior->osca_id)->first();
    if ($appUser) {
        echo "✓ AppUser found: ID {$appUser->id}\n";
        echo "  AppUser Name: {$appUser->first_name} {$appUser->last_name}\n";
        echo "  AppUser Role: {$appUser->role}\n";
    } else {
        echo "✗ NO AppUser found for this OSCA ID\n";
    }
    
    echo "---\n\n";
}

// Check for AppUsers without corresponding seniors
echo "\n=== CHECKING FOR ORPHANED APP USERS ===\n";
$appUsers = AppUser::all();
foreach ($appUsers as $appUser) {
    $senior = Senior::where('osca_id', $appUser->osca_id)->first();
    if (!$senior) {
        echo "⚠️  AppUser {$appUser->id} ({$appUser->osca_id}) has no corresponding Senior\n";
    } elseif (!$senior->has_app_account) {
        echo "⚠️  Senior {$senior->id} ({$senior->osca_id}) has AppUser but has_app_account is false\n";
    }
}

echo "\nDone.\n";