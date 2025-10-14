<?php

require_once 'vendor/autoload.php';

// Load Laravel app
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\AppUser;
use App\Models\Senior;
use Illuminate\Support\Facades\Hash;

// Find a senior without an app account to create one for
$senior = Senior::where('has_app_account', false)->first();

if (!$senior) {
    echo "No senior without app account found. Using first senior.\n";
    $senior = Senior::first();
}

if (!$senior) {
    echo "No seniors found in database!\n";
    exit(1);
}

echo "Creating test AppUser for Senior: {$senior->osca_id} - {$senior->first_name} {$senior->last_name}\n";

// Check if AppUser already exists
$existingAppUser = AppUser::where('osca_id', $senior->osca_id)->first();

if ($existingAppUser) {
    echo "AppUser already exists. Updating password...\n";
    $existingAppUser->password = Hash::make('TestPass123!');
    $existingAppUser->save();
    echo "Password updated for existing AppUser.\n";
} else {
    // Create new AppUser
    $appUser = AppUser::create([
        'osca_id' => $senior->osca_id,
        'first_name' => $senior->first_name,
        'last_name' => $senior->last_name,
        'email' => $senior->email,
        'password' => Hash::make('TestPass123!'),
        'role' => 'senior',
    ]);
    echo "New AppUser created.\n";
}

// Update senior to mark as having app account
$senior->has_app_account = true;
$senior->save();

echo "Test credentials:\n";
echo "OSCA ID: {$senior->osca_id}\n";
echo "Password: TestPass123!\n";
echo "Senior ID: {$senior->id}\n";