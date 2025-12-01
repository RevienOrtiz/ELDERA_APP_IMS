<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\OCRController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Handle CORS preflight for all API routes
Route::options('/{any}', function (Request $request) {
    return response()->noContent();
})->where('any', '.*');

// OCR Processing Routes
Route::post('/ocr/process', [OCRController::class, 'process']);
Route::post('/vision/process-form', [App\Http\Controllers\Api\GoogleVisionController::class, 'processForm']);
Route::get('/vision/check-status/{jobId}', [App\Http\Controllers\Api\GoogleVisionController::class, 'checkStatus']);

// Public routes
Route::post('/login', [App\Http\Controllers\Api\AuthController::class, 'login']);
Route::post('/register', [App\Http\Controllers\Api\AuthController::class, 'register']);

// Local-only debug route to reset AppUser password (for development/testing)
if (app()->environment('local')) {
    Route::post('/debug/reset-app-user-password', function (Request $request) {
        $validated = $request->validate([
            'osca_id' => 'required|string',
            'new_password' => 'required|string|min:8',
        ]);

        $oscaId = $validated['osca_id'];
        $oscaIdNoHyphen = str_replace('-', '', $oscaId);
        $oscaIdWithHyphen = substr($oscaIdNoHyphen, 0, 4) . '-' . substr($oscaIdNoHyphen, 4);

        $appUser = \App\Models\AppUser::where('osca_id', $oscaId)
            ->orWhere('osca_id', $oscaIdNoHyphen)
            ->orWhere('osca_id', $oscaIdWithHyphen)
            ->first();

        if (!$appUser) {
            return response()->json(['success' => false, 'message' => 'AppUser not found'], 404);
        }

        $appUser->password = \Illuminate\Support\Facades\Hash::make($validated['new_password']);
        $appUser->save();

        return response()->json([
            'success' => true,
            'message' => 'Password reset successfully',
            'osca_id' => $appUser->osca_id,
        ]);
    });
}

// Senior Authentication Routes (for Eldera mobile app)
Route::post('/senior/login', [App\Http\Controllers\Api\SeniorAuthController::class, 'login']);
Route::post('/senior/direct-login', [App\Http\Controllers\Api\SeniorAuthController::class, 'directLogin']);
Route::post('/senior/register', [App\Http\Controllers\Api\SeniorAuthController::class, 'register']);
Route::post('/senior/forgot-password', [App\Http\Controllers\Api\SeniorAuthController::class, 'forgotPassword']);

// Public Announcements API (for Eldera app)
Route::get('/announcements', [App\Http\Controllers\Api\AnnouncementController::class, 'index']);
Route::get('/announcements/{id}', [App\Http\Controllers\Api\AnnouncementController::class, 'show']);

// Public Events API (for calendar functionality)
Route::get('/events', [App\Http\Controllers\Api\EventController::class, 'index']);
Route::get('/events/calendar', [App\Http\Controllers\Api\EventController::class, 'calendar']);
Route::get('/events/{id}', [App\Http\Controllers\Api\EventController::class, 'show']);
Route::get('/events/attendance/user', [App\Http\Controllers\Api\EventController::class, 'getUserAttendance']);

// Public Senior Search API (for participant management)
Route::get('/seniors/search', [App\Http\Controllers\Api\SeniorController::class, 'search']);

// Protected routes with rate limiting
Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    // User authentication
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
    Route::post('/logout', [App\Http\Controllers\Api\AuthController::class, 'logout']);
    
    // Senior authentication (for Eldera mobile app)
    Route::get('/senior/profile', [App\Http\Controllers\Api\SeniorAuthController::class, 'profile']);
    Route::post('/senior/logout', [App\Http\Controllers\Api\SeniorAuthController::class, 'logout']);
    
    // Senior Citizens
    Route::get('/seniors', [App\Http\Controllers\Api\SeniorController::class, 'index']);
    Route::get('/seniors/{id}', [App\Http\Controllers\Api\SeniorController::class, 'show']);
    Route::put('/seniors/{id}', [App\Http\Controllers\Api\SeniorController::class, 'update']);
    Route::post('/seniors/{id}/documents', [App\Http\Controllers\Api\SeniorController::class, 'uploadDocument']);
    Route::get('/seniors/{id}/documents', [App\Http\Controllers\Api\SeniorController::class, 'getDocuments']);
    Route::get('/seniors/{id}/photo', [App\Http\Controllers\SeniorController::class, 'servePhoto'])->name('api.seniors.photo');
    
    // Applications
    Route::post('/applications/id', [App\Http\Controllers\Api\ApplicationController::class, 'storeIdApplication']);
    Route::post('/applications/pension', [App\Http\Controllers\Api\ApplicationController::class, 'storePensionApplication']);
    Route::post('/applications/benefits', [App\Http\Controllers\Api\ApplicationController::class, 'storeBenefitsApplication']);
    Route::get('/applications/status/{id}', [App\Http\Controllers\Api\ApplicationController::class, 'checkStatus']);
    
    // Documents
    Route::post('/documents/upload', [App\Http\Controllers\Api\DocumentController::class, 'upload']);
    Route::post('/documents/upload-multiple', [App\Http\Controllers\Api\DocumentController::class, 'uploadMultiple']);
    Route::get('/documents', [App\Http\Controllers\Api\DocumentController::class, 'index']);
    Route::delete('/documents/{id}', [App\Http\Controllers\Api\DocumentController::class, 'destroy']);
    
    // Notifications
    Route::get('/notifications', [App\Http\Controllers\Api\NotificationController::class, 'index']);
    Route::post('/notifications/{id}/read', [App\Http\Controllers\Api\NotificationController::class, 'markAsRead']);
    Route::post('/notifications/read-all', [App\Http\Controllers\Api\NotificationController::class, 'markAllAsRead']);
    Route::get('/notifications/stats', [App\Http\Controllers\Api\NotificationController::class, 'stats']);
    Route::delete('/notifications/{id}', [App\Http\Controllers\Api\NotificationController::class, 'destroy']);
});
