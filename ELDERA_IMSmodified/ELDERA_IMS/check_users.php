<?php

require_once 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\AppUser;

echo "AppUser count: " . AppUser::count() . "\n";
echo "AppUser records:\n";

foreach (AppUser::all() as $user) {
    echo "OSCA ID: " . $user->osca_id . ", Name: " . $user->first_name . " " . $user->last_name . "\n";
}