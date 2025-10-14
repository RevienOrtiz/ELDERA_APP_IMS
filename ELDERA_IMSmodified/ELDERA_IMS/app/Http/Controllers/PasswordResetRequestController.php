<?php

namespace App\Http\Controllers;

use App\Models\PasswordResetRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class PasswordResetRequestController extends Controller
{
    /**
     * Display a listing of password reset requests.
     */
    public function index(Request $request)
    {
        $query = PasswordResetRequest::query();

        // Filter by status if provided
        if ($request->has('status') && $request->status !== 'all') {
            $query->where('status', $request->status);
        }

        // Search by OSCA ID or full name
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('osca_id', 'like', "%{$search}%")
                  ->orWhere('full_name', 'like', "%{$search}%");
            });
        }

        $requests = $query->orderBy('requested_at', 'desc')->paginate(10);

        return view('admin.password-reset-requests.index', compact('requests'));
    }

    /**
     * Show the form for viewing a specific password reset request.
     */
    public function show(PasswordResetRequest $passwordResetRequest)
    {
        return view('admin.password-reset-requests.show', compact('passwordResetRequest'));
    }

    /**
     * Approve a password reset request.
     */
    public function approve(Request $request, PasswordResetRequest $passwordResetRequest)
    {
        $request->validate([
            'notes' => 'nullable|string|max:500'
        ]);

        $adminName = Auth::user()->name ?? 'Admin';
        $passwordResetRequest->approve($adminName, $request->notes);

        return redirect()->route('admin.password-reset-requests.index')
                        ->with('success', 'Password reset request approved successfully.');
    }

    /**
     * Reject a password reset request.
     */
    public function reject(Request $request, PasswordResetRequest $passwordResetRequest)
    {
        $request->validate([
            'notes' => 'nullable|string|max:500'
        ]);

        $adminName = Auth::user()->name ?? 'Admin';
        $passwordResetRequest->reject($adminName, $request->notes);

        return redirect()->route('admin.password-reset-requests.index')
                        ->with('success', 'Password reset request rejected successfully.');
    }

    /**
     * Delete a resolved password reset request.
     */
    public function destroy(PasswordResetRequest $passwordResetRequest)
    {
        // Only allow deletion of resolved requests
        if ($passwordResetRequest->status === 'pending') {
            return redirect()->route('admin.password-reset-requests.index')
                            ->with('error', 'Cannot delete pending requests. Please approve or reject first.');
        }

        $passwordResetRequest->delete();

        return redirect()->route('admin.password-reset-requests.index')
                        ->with('success', 'Password reset request deleted successfully.');
    }

    /**
     * Mark a request as resolved (for the "resolve" functionality)
     */
    public function resolve(PasswordResetRequest $passwordResetRequest)
    {
        // This will delete the request as per user's requirement
        $passwordResetRequest->delete();

        return redirect()->route('admin.password-reset-requests.index')
                        ->with('success', 'Password reset request resolved and removed.');
    }
}
