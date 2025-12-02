<x-sidebar>
<x-header title="Password Reset Request Details" icon="fas fa-key">
    @include('message.popup_message')
    <style>
        .main-container {
            margin-left: 250px;
            margin-top: 60px;
            height: calc(100vh - 60px);
            min-height: calc(100vh - 60px);
            padding: 0;
            background: #f3f4f6;
            overflow: auto;
        }

        .page-header {
            background: linear-gradient(135deg, #ffb7ce 0%, #ff9bb8 100%);
            color: #2c3e50;
            padding: 18px 24px;
            border-radius: 0;
            margin: 0;
            box-shadow: 0 4px 12px rgba(227, 21, 117, 0.15);
            border-bottom: 3px solid #e31575;
            position: sticky;
            top: 0;
            z-index: 3;
            width: 100%;
            min-height: 68px;
        }

        .page-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .back-link {
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            font-size: 0.9rem;
            margin-top: 10px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: white;
        }

        .request-details-card {
            background: #ffffff;
            border-radius: 0;
            padding: 24px;
            margin: 0;
            box-shadow: 0 2px 8px rgba(17, 24, 39, 0.05);
            border: 1px solid #e5e7eb;
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .detail-item {
            padding: 16px;
            background: #fbf7f2;
            border-radius: 12px;
            border: 1px solid #ececec;
            box-shadow: 0 1px 2px rgba(17, 24, 39, 0.06);
        }

        .detail-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.1px;
            margin-bottom: 6px;
        }

        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: #111827;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-approved {
            background: #d1edff;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .actions-section {
            background: #ffffff;
            border-radius: 0;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(17, 24, 39, 0.05);
            border: 1px solid #e5e7eb;
            margin: 0;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .action-card {
            padding: 25px;
            border-radius: 10px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-2px);
        }

        .approve-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
        }

        .reject-card {
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
        }

        .action-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .action-description {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 20px;
        }

        .action-form {
            margin-top: 15px;
        }

        .notes-input {
            width: 100%;
            padding: 12px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 8px;
            background: rgba(255,255,255,0.1);
            color: white;
            font-size: 0.9rem;
            margin-bottom: 15px;
            resize: vertical;
            min-height: 80px;
        }

        .notes-input::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .notes-input:focus {
            outline: none;
            border-color: rgba(255,255,255,0.5);
            background: rgba(255,255,255,0.15);
        }

        .action-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 2px solid rgba(255,255,255,0.3);
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        .action-btn:hover {
            background: rgba(255,255,255,0.3);
            border-color: rgba(255,255,255,0.5);
        }

        .resolved-notice {
            background: #d1ecf1;
            color: #0c5460;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin: 16px 0;
            border: 1px solid #bee5eb;
        }

        .resolve-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid #e9ecef;
            text-align: center;
        }

        .resolve-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .resolve-btn:hover {
            background: #218838;
            transform: translateY(-2px);
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid transparent;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }

        @media (max-width: 768px) {
            .main-container {
                margin-left: 0;
                padding: 15px;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="main-container">

        <!-- Success/Error Messages -->
        @if(session('success'))
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                {{ session('success') }}
            </div>
        @endif

        @if(session('error'))
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                {{ session('error') }}
            </div>
        @endif

        <!-- Request Details -->
        <div class="request-details-card">
            <h2 class="card-title">
                <i class="fas fa-info-circle"></i>
                Request Details
            </h2>

            <div class="details-grid">
                <div class="detail-item">
                    <div class="detail-label">Request ID</div>
                    <div class="detail-value">#{{ $passwordResetRequest->id }}</div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">OSCA ID</div>
                    <div class="detail-value">{{ $passwordResetRequest->osca_id }}</div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">Full Name</div>
                    <div class="detail-value">{{ $passwordResetRequest->full_name }}</div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">Status</div>
                    <div class="detail-value">
                        <span class="status-badge status-{{ $passwordResetRequest->status }}">
                            {{ ucfirst($passwordResetRequest->status) }}
                        </span>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">Requested At</div>
                    <div class="detail-value">{{ $passwordResetRequest->requested_at->format('M d, Y h:i A') }}</div>
                </div>

                <div class="detail-item">
                    <div class="detail-label">IP Address</div>
                    <div class="detail-value">{{ $passwordResetRequest->ip_address ?? 'N/A' }}</div>
                </div>

                @if($passwordResetRequest->resolved_at)
                    <div class="detail-item">
                        <div class="detail-label">Resolved At</div>
                        <div class="detail-value">{{ $passwordResetRequest->resolved_at->format('M d, Y h:i A') }}</div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">Resolved By</div>
                        <div class="detail-value">{{ $passwordResetRequest->resolved_by ?? 'N/A' }}</div>
                    </div>
                @endif

                @if($passwordResetRequest->notes)
                    <div class="detail-item" style="grid-column: 1 / -1;">
                        <div class="detail-label">Admin Notes</div>
                        <div class="detail-value">{{ $passwordResetRequest->notes }}</div>
                    </div>
                @endif
            </div>
        </div>

        <!-- Actions Section -->
        @if($passwordResetRequest->status === 'pending')
            <div class="actions-section">
                <h2 class="card-title">
                    <i class="fas fa-cogs"></i>
                    Actions
                </h2>

                <div class="actions-grid">
                    <!-- Approve Action -->
                    <div class="action-card approve-card">
                        <div class="action-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="action-title">Approve Request</div>
                        <div class="action-description">
                            Mark this request as approved. The admin can then proceed to update the password in APP ACCOUNT.
                        </div>
                        
                        <form id="approveForm" method="POST" action="{{ route('admin.password-reset-requests.approve', $passwordResetRequest) }}" class="action-form">
                            @csrf
                            <textarea name="notes" class="notes-input" placeholder="Optional notes (e.g., password updated, user contacted, etc.)"></textarea>
                            <button type="button" class="action-btn" onclick="window.confirmFormId='approveForm'; showConfirmModal('Approve Request', 'Are you sure you want to approve this password reset request?', document.getElementById('approveForm').action, 'POST');">
                                <i class="fas fa-check"></i>
                                Approve Request
                            </button>
                        </form>
                    </div>

                    <!-- Reject Action -->
                    <div class="action-card reject-card">
                        <div class="action-icon">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="action-title">Reject Request</div>
                        <div class="action-description">
                            Mark this request as rejected if it's invalid or cannot be processed.
                        </div>
                        
                        <form id="rejectForm" method="POST" action="{{ route('admin.password-reset-requests.reject', $passwordResetRequest) }}" class="action-form">
                            @csrf
                            <textarea name="notes" class="notes-input" placeholder="Reason for rejection (required for rejected requests)"></textarea>
                            <button type="button" class="action-btn" onclick="window.confirmFormId='rejectForm'; showConfirmModal('Reject Request', 'Are you sure you want to reject this password reset request?', document.getElementById('rejectForm').action, 'POST');">
                                <i class="fas fa-times"></i>
                                Reject Request
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        @else
            <!-- Resolved Notice -->
            <div class="resolved-notice">
                <i class="fas fa-info-circle"></i>
                <strong>This request has been {{ $passwordResetRequest->status }}.</strong>
                @if($passwordResetRequest->status === 'approved')
                    You can now proceed to update the password in the APP ACCOUNT section.
                @endif
            </div>

            <!-- Resolve Section -->
            <div class="resolve-section">
                <h2 class="card-title">
                    <i class="fas fa-check-double"></i>
                    Mark as Resolved
                </h2>
                <p style="margin-bottom: 25px; color: #6c757d;">
                    Once you have completed the password update in APP ACCOUNT, click the button below to remove this request from the system.
                </p>
                
                <form id="resolveForm" method="POST" action="{{ route('admin.password-reset-requests.resolve', $passwordResetRequest) }}" style="display: inline;">
                    @csrf
                    @method('DELETE')
                    <button type="button" class="resolve-btn" onclick="window.confirmFormId='resolveForm'; showConfirmModal('Resolve Request', 'Are you sure you want to resolve this request? This will remove it from the system.', document.getElementById('resolveForm').action, 'DELETE');">
                        <i class="fas fa-check-double"></i>
                        Mark as Resolved & Remove
                    </button>
                </form>
            </div>
        @endif
    </div>
</x-header>
</x-sidebar>
