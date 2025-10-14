<?php

require_once 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\AppUser;
use Illuminate\Support\Facades\Hash;

// Create or update Fleta Kohler with a known password
$appUser = AppUser::where('osca_id', '2025-005')->first();

if ($appUser) {
    // Update existing user with known password
    $appUser->password = Hash::make('password123');
    $appUser->save();
    echo "Updated Fleta Kohler's password to 'password123'\n";
} else {
    echo "AppUser with OSCA ID 2025-005 not found\n";
}

// Also create a simple test user if needed
$testUser = AppUser::where('osca_id', 'TEST-001')->first();
if (!$testUser) {
    AppUser::create([
        'osca_id' => 'TEST-001',
        'first_name' => 'Test',
        'last_name' => 'User',
        'email' => 'test@example.com',
        'password' => Hash::make('password123'),
        'role' => 'senior',
    ]);
    echo "Created test user with OSCA ID 'TEST-001' and password 'password123'\n";
}

echo "Test credentials:\n";
echo "OSCA ID: 2025-005, Password: password123 (Fleta Kohler)\n";
echo "OSCA ID: TEST-001, Password: password123 (Test User)\n";