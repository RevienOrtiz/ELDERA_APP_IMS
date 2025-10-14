<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PasswordResetRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'osca_id',
        'full_name',
        'status',
        'requested_at',
        'resolved_at',
        'resolved_by',
        'notes',
        'ip_address',
    ];

    protected $casts = [
        'requested_at' => 'datetime',
        'resolved_at' => 'datetime',
    ];

    /**
     * Scope to get pending requests
     */
    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    /**
     * Scope to get resolved requests
     */
    public function scopeResolved($query)
    {
        return $query->whereIn('status', ['approved', 'rejected']);
    }

    /**
     * Mark request as approved
     */
    public function approve($adminName, $notes = null)
    {
        $this->update([
            'status' => 'approved',
            'resolved_at' => now(),
            'resolved_by' => $adminName,
            'notes' => $notes,
        ]);
    }

    /**
     * Mark request as rejected
     */
    public function reject($adminName, $notes = null)
    {
        $this->update([
            'status' => 'rejected',
            'resolved_at' => now(),
            'resolved_by' => $adminName,
            'notes' => $notes,
        ]);
    }
}
