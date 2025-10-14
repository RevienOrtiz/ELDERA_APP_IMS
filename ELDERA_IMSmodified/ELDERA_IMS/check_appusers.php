<?php

require_once 'vendor/autoload.php';

// Load Laravel app
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\AppUser;

echo "AppUsers count: " . AppUser::count() . "\n";
echo "First 5 AppUsers:\n";

$users = AppUser::select('id', 'osca_id', 'first_name', 'last_name')->take(5)->get();

foreach ($users as $user) {
    echo "ID: {$user->id}, OSCA: {$user->osca_id}, Name: {$user->first_name} {$user->last_name}\n";
}

// Check if there's a user with OSCA ID 2025-001
$testUser = AppUser::where('osca_id', '2025-001')->first();
if ($testUser) {
    echo "\nFound test user 2025-001: {$testUser->first_name} {$testUser->last_name}\n";
} else {
    echo "\nNo user found with OSCA ID 2025-001\n";
}