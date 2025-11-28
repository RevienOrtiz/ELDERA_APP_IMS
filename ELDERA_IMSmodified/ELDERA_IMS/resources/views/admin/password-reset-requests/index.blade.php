<x-sidebar>
<x-header title="Password Reset Requests" icon="fas fa-key">
    <style>
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: calc(100vh - 80px);
            margin-left: 280px;
            margin-top: 80px;
        }

        .page-header {
            background: #e31575;
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-top: 10px;
        }

        .filters-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid #e9ecef;
        }

        .filters-row {
            display: flex;
            gap: 20px;
            align-items: end;
            flex-wrap: wrap;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-label {
            display: block;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 0.9rem;
        }

        .filter-input, .filter-select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .filter-input:focus, .filter-select:focus {
            outline: none;
            border-color: #e31575;
            box-shadow: 0 0 0 3px rgba(227, 21, 117, 0.1);
        }

        .filter-btn {
            background: #e31575;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-btn:hover {
            background: #c41464;
            transform: translateY(-2px);
        }

        .requests-table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            border: 1px solid #e9ecef;
        }

        .table-header {
            background: #f8f9fa;
            padding: 20px 25px;
            border-bottom: 1px solid #e9ecef;
        }

        .table-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .requests-table {
            width: 100%;
            border-collapse: collapse;
        }

        .requests-table th {
            background: #f8f9fa;
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #e9ecef;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .requests-table td {
            padding: 18px 20px;
            border-bottom: 1px solid #f1f3f4;
            vertical-align: middle;
        }

        .requests-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-view {
            background: #17a2b8;
            color: white;
        }

        .btn-view:hover {
            background: #138496;
            transform: translateY(-1px);
        }

        .btn-resolve {
            background: #28a745;
            color: white;
        }

        .btn-resolve:hover {
            background: #218838;
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 1rem;
            opacity: 0.8;
        }

        .pagination-wrapper {
            padding: 20px 25px;
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
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
            
            .filters-row {
                flex-direction: column;
            }
            
            .filter-group {
                min-width: 100%;
            }
            
            .requests-table {
                font-size: 0.85rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>

    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-key"></i>
                Password Reset Requests
            </h1>
            <p class="page-subtitle">Manage password reset requests from senior citizens</p>
        </div>

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

        <!-- Filters Section -->
        <div class="filters-section">
            <form method="GET" action="{{ route('admin.password-reset-requests.index') }}">
                <div class="filters-row">
                    <div class="filter-group">
                        <label class="filter-label">Status</label>
                        <select name="status" class="filter-select">
                            <option value="all" {{ request('status') == 'all' ? 'selected' : '' }}>All Statuses</option>
                            <option value="pending" {{ request('status') == 'pending' ? 'selected' : '' }}>Pending</option>
                            <option value="approved" {{ request('status') == 'approved' ? 'selected' : '' }}>Approved</option>
                            <option value="rejected" {{ request('status') == 'rejected' ? 'selected' : '' }}>Rejected</option>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label class="filter-label">Search</label>
                        <input type="text" name="search" class="filter-input" 
                               placeholder="OSCA ID or Name" 
                               value="{{ request('search') }}">
                    </div>
                    <div class="filter-group">
                        <button type="submit" class="filter-btn">
                            <i class="fas fa-search"></i>
                            Filter
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Requests Table -->
        <div class="requests-table-container">
            <div class="table-header">
                <h2 class="table-title">
                    <i class="fas fa-list"></i>
                    Password Reset Requests ({{ $requests->total() }} Total)
                </h2>
            </div>

            @if($requests->count() > 0)
                <table class="requests-table">
                    <thead>
                        <tr>
                            <th>Request ID</th>
                            <th>OSCA ID</th>
                            <th>Full Name</th>
                            <th>Status</th>
                            <th>Requested At</th>
                            <th>Resolved At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($requests as $request)
                            <tr>
                                <td>#{{ $request->id }}</td>
                                <td><strong>{{ $request->osca_id }}</strong></td>
                                <td>
                                    @php
                                        $ln = $request->last_name ?? null;
                                        $fn = $request->first_name ?? null;
                                        $mn = $request->middle_name ?? null;
                                        $ext = $request->name_extension ?? null;

                                        // Fallback: derive parts from full_name when individual fields are absent
                                        $derived = null;
                                        if ((!$ln || !$fn) && !empty($request->full_name)) {
                                            $full = trim($request->full_name);
                                            $parts = array_values(array_filter(preg_split('/\s+/', $full)));
                                            $nameExt = '';
                                            $knownExt = ['jr', 'jr.', 'sr', 'sr.', 'ii', 'iii', 'iv', 'v'];
                                            if (count($parts) > 2) {
                                                $lastToken = strtolower(end($parts));
                                                if (in_array($lastToken, $knownExt, true)) {
                                                    // Normalize extension casing
                                                    $map = ['jr' => 'Jr.', 'jr.' => 'Jr.', 'sr' => 'Sr.', 'sr.' => 'Sr.', 'ii' => 'II', 'iii' => 'III', 'iv' => 'IV', 'v' => 'V'];
                                                    $nameExt = $map[$lastToken];
                                                    array_pop($parts);
                                                }
                                            }
                                            if (count($parts) >= 2) {
                                                $first = array_shift($parts);
                                                $last = array_pop($parts);
                                                $middle = count($parts) ? implode(' ', $parts) : '';
                                                $derived = trim(ucfirst($last) . ', ' . ucfirst($first) . ($middle ? ' ' . ucwords($middle) : '') . ($nameExt ? ' ' . $nameExt : ''));
                                            }
                                        }
                                    @endphp
                                    @if($ln && $fn)
                                        {{ ucfirst($ln) }}, {{ ucfirst($fn) }}{{ $mn ? ' ' . ucfirst($mn) : '' }}{{ $ext ? ' ' . ucfirst($ext) : '' }}
                                    @else
                                        {{ $derived ?? ucwords($request->full_name) }}
                                    @endif
                                </td>
                                <td>
                                    <span class="status-badge status-{{ $request->status }}">
                                        {{ ucfirst($request->status) }}
                                    </span>
                                </td>
                                <td>{{ $request->requested_at->format('M d, Y h:i A') }}</td>
                                <td>
                                    {{ $request->resolved_at ? $request->resolved_at->format('M d, Y h:i A') : '-' }}
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="{{ route('admin.password-reset-requests.show', $request) }}" 
                                           class="btn btn-view">
                                            <i class="fas fa-eye"></i>
                                            View
                                        </a>
                                        @if($request->status !== 'pending')
                                            <form method="POST" 
                                                  action="{{ route('admin.password-reset-requests.resolve', $request) }}" 
                                                  style="display: inline;"
                                                  onsubmit="return confirm('Are you sure you want to resolve this request? This will remove it from the list.')">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-resolve">
                                                    <i class="fas fa-check"></i>
                                                    Resolve
                                                </button>
                                            </form>
                                        @endif
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination-wrapper">
                    {{ $requests->appends(request()->query())->links() }}
                </div>
            @else
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Password Reset Requests</h3>
                    <p>There are currently no password reset requests matching your criteria.</p>
                </div>
            @endif
        </div>
    </div>
</x-header>
</x-sidebar>
