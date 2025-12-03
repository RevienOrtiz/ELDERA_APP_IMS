<x-sidebar>
<x-header title="Password Reset Requests" icon="fas fa-key">
    @include('message.popup_message')
    <style>
        .main-container {
            margin-left: 250px;
            margin-top: 60px;
            height: calc(100vh - 60px);
            min-height: calc(100vh - 60px);
            padding: 0;
            background: #f3f4f6;
            overflow: hidden;
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

        .page-subtitle {
            font-size: .95rem;
            opacity: .9;
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .sub-toolbar {
            position: sticky;
            top: 0;
            z-index: 2;
            background: #1f2937;
            padding: 12px 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #111827;
        }
        .toolbar-stats { display: flex; align-items: center; gap: 16px; color: #e5e7eb; }
        .toolbar-stat-label { font-weight: 600; margin-right: 6px; }
        .toolbar-stat-value { font-weight: 800; color: #fff; }

        .table-search { display: flex; align-items: center; gap: 8px; }
        .search-container { position: relative; display: flex; align-items: center; width: clamp(240px, 40vw, 360px); }
        .search-icon { position: absolute; left: 12px; color: #666; font-size: 0.9rem; z-index: 1; }
        .search-input { width: 100%; padding: 10px 40px 10px 35px; border: 2px solid #ddd; border-radius: 8px; font-size: 0.9rem; background: #fff; transition: all 0.3s ease; }
        .search-input:focus { outline: none; border-color: #CC0052; box-shadow: 0 0 0 3px rgba(204, 0, 82, 0.1); }
        .clear-search { position: absolute; right: 8px; background: none; border: none; color: #666; cursor: pointer; padding: 4px; border-radius: 4px; transition: all 0.2s ease; display: none; }
        .clear-search:hover { background: #f0f0f0; color: #333; }
        .clear-btn {
            border: none;
            background: transparent;
            font-size: 18px;
            cursor: pointer;
            color: #6b7280;
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
            border-radius: 0;
            overflow: hidden;
            border: 1px solid #e5e7eb;
            box-shadow: 0 6px 16px rgba(0,0,0,0.06);
        }

        .table-header {
            background: #f8fafc;
            padding: 14px 16px;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .table-title {
            font-size: 1rem;
            font-weight: 700;
            color: #374151;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .requests-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: auto;
            word-wrap: break-word;
            border: 1px solid #ddd;
            font-size: 0.85rem;
        }

        .table-scroll {
            max-height: calc(100vh - 260px);
            overflow-y: auto;
        }

        .requests-table thead th {
            position: sticky;
            top: 0;
            background: #f5f5f5;
            z-index: 3;
        }

        .requests-table th {
            background: #f5f5f5;
            color: #333;
            padding: 10px 12px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.4px;
            border: 1px solid #ddd;
        }

        .requests-table td {
            padding: 10px 12px;
            border: 1px solid #ddd;
            vertical-align: middle;
            color: #555;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .requests-table tr:hover {
            background: #f8f9fa;
        }

        .status-badge {
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
        }
        .status-pending { background: #fff7db; color: #7c6a00; }
        .status-approved { background: #dbeafe; color: #1e40af; }
        .status-rejected { background: #fee2e2; color: #991b1b; }

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
        <div class="page-header">
            <h1 class="page-title">
                Recovery Requests
            </h1>
            @php
                $totalCount = \App\Models\PasswordResetRequest::count();
            @endphp
            <div class="page-subtitle">
                <span>Admin Console</span>
                <span>•</span>
                <span>Total {{ $totalCount }}</span>
            </div>
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

        @php
            $pendingCount = \App\Models\PasswordResetRequest::where('status','pending')->count();
            $approvedCount = \App\Models\PasswordResetRequest::where('status','approved')->count();
            $rejectedCount = \App\Models\PasswordResetRequest::where('status','rejected')->count();
        @endphp
        <div class="sub-toolbar">
            <div class="toolbar-stats">
                <div class="toolbar-stat"><span class="toolbar-stat-label">Pending:</span><span class="toolbar-stat-value">{{ $pendingCount }}</span></div>
                <div class="toolbar-stat"><span class="toolbar-stat-label">Approved:</span><span class="toolbar-stat-value">{{ $approvedCount }}</span></div>
                <div class="toolbar-stat"><span class="toolbar-stat-label">Rejected:</span><span class="toolbar-stat-value">{{ $rejectedCount }}</span></div>
            </div>
            <div class="table-search" style="margin-left:auto;">
                <form id="passwordResetSearchForm" method="GET" action="{{ route('admin.password-reset-requests.index') }}" class="search-container">
                    <i class="fas fa-search search-icon" aria-hidden="true"></i>
                    <input id="passwordResetSearchInput" type="text" name="search" class="search-input" placeholder="Search Senior Citizen" value="{{ request('search') }}" aria-label="Search OSCA ID or Name">
                    <button type="button" id="passwordResetClear" class="clear-search" aria-label="Clear search"><i class="fas fa-times"></i></button>
                </form>
            </div>
        </div>

        <!-- Requests Table -->
        <div class="requests-table-container">
            @if($requests->count() > 0)
                <div class="table-scroll">
                <table class="requests-table">
                    <colgroup>
                        <col style="width:10%">
                        <col style="width:14%">
                        <col style="width:36%">
                        <col style="width:12%">
                        <col style="width:14%">
                        <col style="width:14%">
                        <col style="width:16%">
                    </colgroup>
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
                            <tr data-osca="{{ strtolower($request->osca_id) }}" data-name="{{ strtolower($request->full_name) }}">
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
                                            <form id="resolveForm_{{ $request->id }}" method="POST" 
                                                  action="{{ route('admin.password-reset-requests.resolve', $request) }}" 
                                                  style="display: inline;">
                                                @csrf
                                                @method('DELETE')
                                                <button type="button" class="btn btn-resolve" onclick="window.confirmFormId='resolveForm_{{ $request->id }}'; showConfirmModal('Resolve Request', 'Are you sure you want to resolve this request? This will remove it from the list.', document.getElementById('resolveForm_{{ $request->id }}').action, 'DELETE');">
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
                </div>

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
    <script>
        (function(){
            var input=document.getElementById('passwordResetSearchInput');
            var clearBtn=document.getElementById('passwordResetClear');
            if(!input) return;
            function rows(){ return Array.from(document.querySelectorAll('.requests-table tbody tr')); }
            function applyFilter(){
                var q=(input.value||'').trim().toLowerCase();
                rows().forEach(function(r){
                    var os=(r.dataset.osca||'');
                    var nm=(r.dataset.name||'');
                    var show=!q || os.indexOf(q)>-1 || nm.indexOf(q)>-1;
                    r.style.display=show?'':'none';
                });
                if(clearBtn) clearBtn.style.display = q ? 'block' : 'none';
            }
            input.addEventListener('input', applyFilter);
            input.addEventListener('keydown', function(e){ if(e.key==='Escape'){ input.value=''; applyFilter(); }});
            if(clearBtn){ clearBtn.addEventListener('click', function(){ input.value=''; applyFilter(); }); }
            applyFilter();
        })();
    </script>
</x-header>
</x-sidebar>
