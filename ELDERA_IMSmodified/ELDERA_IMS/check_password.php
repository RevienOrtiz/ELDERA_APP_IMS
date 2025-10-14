<?php

require_once 'vendor/autoload.php';

// Load Laravel app
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\AppUser;
use Illuminate\Support\Facades\Hash;

// Get the first user
$user = AppUser::first();
if ($user) {
    echo "User: {$user->osca_id} - {$user->first_name} {$user->last_name}\n";
    echo "Password hash length: " . strlen($user->password) . "\n";
    echo "Password hash starts with: " . substr($user->password, 0, 10) . "...\n";
    
    // Test common passwords
    $testPasswords = ['password', 'password123', '123456', 'admin123'];
    
    foreach ($testPasswords as $testPassword) {
        if (Hash::check($testPassword, $user->password)) {
            echo "✓ Password '{$testPassword}' matches!\n";
        } else {
            echo "✗ Password '{$testPassword}' does not match\n";
        }
    }
} else {
    echo "No AppUser found\n";
}