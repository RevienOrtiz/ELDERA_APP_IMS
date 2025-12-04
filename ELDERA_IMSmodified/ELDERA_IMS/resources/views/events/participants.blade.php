<x-sidebar>
    <x-header title="Manage Participants" icon="fas fa-users">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        @include('message.popup_message')
        
        <div class="main {{ $event->event_type }}">
            <!-- Event Banner -->
            <div class="event-banner {{ $event->event_type }} {{ $event->computed_status }}">
                <div class="event-banner-content">
                    <div class="banner-left">
                        <h1 class="event-title">{{ $event->title }}</h1>
                        <div class="event-details">
                        <div class="event-detail-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span>{{ $event->event_date->format('F d, Y') }}</span>
                        </div>
                        <div class="event-detail-item">
                            <i class="fas fa-clock"></i>
                            <span>{{ (function($t){ if($t instanceof \Carbon\CarbonInterface) return $t->format('g:i A'); if(is_string($t) && $t!==''){ try { return \Carbon\Carbon::createFromFormat('H:i:s',$t)->format('g:i A'); } catch (\Throwable $e) { return 'N/A'; } } return 'N/A'; })($event->start_time) }}</span>
                        </div>
                        <div class="event-detail-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>{{ $event->location }}</span>
                        </div>
                        </div>
                    </div>
                    
                </div>
            </div>

            <!-- Participants Management Section -->
            <div class="participants-section">
                <div class="section-header toolbar">
                    <div class="toolbar-left">
                        <div class="toolbar-stats">
                            <div class="toolbar-stat">
                                <span class="toolbar-stat-label">Total Registered:</span>
                                <span class="toolbar-stat-value">{{ $event->current_participants }}</span>
                            </div>
                            <div class="toolbar-stat">
                                <span class="toolbar-stat-label">Attended:</span>
                                <span class="toolbar-stat-value">{{ $event->participants()->wherePivot('attended', true)->count() }}</span>
                            </div>
                            <div class="toolbar-stat">
                                <span class="toolbar-stat-label">Attendance Rate:</span>
                                <span class="toolbar-stat-value">{{ $event->current_participants > 0 ? round(($event->participants()->wherePivot('attended', true)->count() / $event->current_participants) * 100, 1) : 0 }}%</span>
                            </div>
                        </div>
                    </div>
                    <div class="toolbar-right" style="margin-left:auto;">
                        <form id="participantsSearchForm" method="GET" action="{{ route('events.participants', $event->id) }}" class="search-container" role="search">
                            <i class="fas fa-search search-icon" aria-hidden="true"></i>
                            <input id="participantsSearchInput" type="text" name="search" class="search-input" placeholder="Search Senior Citizen" value="{{ request('search') }}" aria-label="Search Senior Citizen">
                            <button type="button" id="participantsClear" class="clear-search" aria-label="Clear search"><i class="fas fa-times"></i></button>
                        </form>
                    </div>
                </div>

                

                <!-- Participants Table -->
                <div class="table-container">
                    <table class="participants-table">
                        <colgroup>
                            <col style="width:6%">
                            <col style="width:14%">
                            <col style="width:36%">
                            <col style="width:8%">
                            <col style="width:10%">
                            <col style="width:16%">
                            <col style="width:10%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>NO.</th>
                                <th>OSCA ID NO.</th>
                                <th>FULL NAME</th>
                                <th>AGE</th>
                                <th>GENDER</th>
                                <th>BARANGAY</th>
                                <th>ATTENDANCE</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($event->participants as $index => $participant)
                                <tr 
                                    data-name="{{ strtolower(($participant->first_name ?? '') . ' ' . ($participant->last_name ?? '')) }}"
                                    data-osca="{{ strtolower($participant->osca_id ?? '') }}"
                                    data-age="{{ $participant->age ?? '' }}"
                                    data-gender="{{ strtolower($participant->sex ?? '') }}"
                                    data-barangay="{{ strtolower($participant->barangay ?? '') }}"
                                    data-attended="{{ $participant->pivot->attended ? '1' : '0' }}">
                                    <td>{{ $index + 1 }}</td>
                                    <td>{{ $participant->osca_id ?? 'N/A' }}</td>
                                    <td>
                                        {{ isset($participant->last_name) ? ucfirst($participant->last_name) : 'N/A' }},
                                        {{ isset($participant->first_name) ? ucfirst($participant->first_name) : '' }}
                                        {{ isset($participant->middle_name) && $participant->middle_name ? ' ' . ucfirst($participant->middle_name) : '' }}
                                        {{ isset($participant->name_extension) && $participant->name_extension ? ' ' . ucfirst($participant->name_extension) : '' }}
                                    </td>
                                    <td>{{ $participant->age ?? 'N/A' }}</td>
                                    <td>{{ isset($participant->sex) ? ucfirst($participant->sex) : 'N/A' }}</td>
                                    <td>{{ isset($participant->barangay) ? implode('-', array_map('ucfirst', explode('-', $participant->barangay))) : 'N/A' }}</td>
                                    <td>
                                        <div class="attendance-toggle">
                                            <span class="toggle-label">No</span>
                                            <label class="switch">
                                                <input type="checkbox" 
                                                       class="attendance-toggle-input"
                                                       data-event-id="{{ $event->id }}"
                                                       data-senior-id="{{ $participant->id }}"
                                                       {{ $participant->pivot->attended ? 'checked' : '' }}>
                                                <span class="slider"></span>
                                            </label>
                                            <span class="toggle-label">Yes</span>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="7" class="text-center">No participants registered yet.</td>
                                </tr>
                            @endforelse
                        </tbody>
                        </table>
                </div>

                
            </div>
        </div>

        <!-- Add Participant Modal -->
        <div id="addParticipantModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Add New Participant</h3>
                    <span class="close" onclick="closeAddParticipantModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <form id="addParticipantForm" method="POST" action="{{ route('events.register', $event->id) }}">
                        @csrf
                        <div class="form-group">
                            <label for="senior_id">Select Senior Citizen</label>
                            <select id="senior_id" name="senior_id" class="form-control" required>
                                <option value="">Choose a senior citizen...</option>
                                @foreach($allSeniors as $senior)
                                    @if(!$event->participants->contains('id', $senior->id))
                                        <option value="{{ $senior->id }}">
                                            {{ $senior->first_name }} {{ $senior->last_name }} 
                                            ({{ $senior->osca_id ?? 'No OSCA ID' }})
                                        </option>
                                    @endif
                                @endforeach
                            </select>
                        </div>
                        <div class="modal-actions">
                            <button type="button" class="btn btn-secondary" onclick="closeAddParticipantModal()">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add Participant</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <style>
            /* Accent color mapping available across the page */
            /* General = Green, Pension = Blue, Health = Red, ID Claiming = Yellow */
            .main.general { --accent-1: #86efac; --accent-2: #22c55e; }
            .main.pension { --accent-1: #93c5fd; --accent-2: #3b82f6; }
            .main.health { --accent-1: #fca5a5; --accent-2: #ef4444; }
            .main.id_claiming { --accent-1: #fde68a; --accent-2: #f59e0b; }
            .main { --accent-1: #f9a8d4; --accent-2: #e31575; }

            .main {
                margin-left: 250px;
                margin-top: 60px;
                height: calc(100vh - 60px);
                min-height: calc(100vh - 60px);
                padding: 0; /* full-width banner */
                background: #f3f4f6;
                overflow: hidden; /* only inner content should scroll */
                display: flex;
                flex-direction: column; /* banner + content stack */
            }

            /* Event Banner - dynamic colors and sticky header */
            .event-banner { --accent-1: #f9a8d4; --accent-2: #e31575; }
            .event-banner.general { --accent-1: #86efac; --accent-2: #22c55e; }
            .event-banner.pension { --accent-1: #93c5fd; --accent-2: #3b82f6; }
            .event-banner.health { --accent-1: #fca5a5; --accent-2: #ef4444; }
            .event-banner.id_claiming { --accent-1: #fde68a; --accent-2: #f59e0b; }
            .event-banner.done { --accent-1: #d1d5db; --accent-2: #6b7280; opacity: 0.92; }

            .event-banner {
                background: var(--accent-2);
                color: white;
                padding: 18px 24px; /* slightly larger to match Add Senior */
                border-radius: 0;
                margin: 0;
                box-shadow: none;
                position: sticky;
                top: 0;
                z-index: 3;
                min-height: 96px;
                display: flex;
                align-items: center; /* vertically center content */
            }

            .event-banner::after {
                content: "";
                position: absolute;
                left: 0; right: 0; bottom: 0;
                height: 3px; /* slimmer accent underline */
                background: var(--accent-2);
                opacity: 0.95;
            }

            .event-title {
                font-size: 24px; /* match toolbar headline size */
                font-weight: 800;
                margin: 0; /* remove extra gap */
                text-shadow: 0 1px 2px rgba(0,0,0,0.25);
            }

            .event-details {
                display: flex;
                gap: 12px; /* tighter spacing */
                flex-wrap: wrap;
            }

            .event-detail-item {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px; /* compact meta size */
                font-weight: 600;
            }

            .event-detail-item i {
                font-size: 16px;
                opacity: 0.9;
            }

            .event-banner-content { display: flex; align-items: center; justify-content: space-between; gap: 16px; }
            .banner-left { display: flex; flex-direction: column; gap: 8px; }
            .banner-stats {
                display: flex;
                gap: 24px;
                margin-top: 10px;
                align-items: center;
                color: #ffffff;
            }
            .banner-stat { display: flex; align-items: baseline; gap: 8px; }
            .banner-label { opacity: 0.9; font-weight: 600; }
            .banner-value { font-weight: 800; }

            /* Participants Section */
            /* Full-width content area: remove card chrome so table touches edges */
            .participants-section {
                background: transparent;
                border-radius: 0;
                box-shadow: none;
                overflow: hidden;
                flex: 1;              /* fill remaining height under banner */
                min-height: 0;        /* enable scrolling */
                overflow-y: hidden;
                padding: 0;           /* no side padding; table is edge-to-edge */
            }

            /* Toolbar (sticky, dark) */
            .section-header.toolbar {
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

            .toolbar-left, .toolbar-right, .toolbar-center {
                display: flex;
                align-items: center;
                gap: 12px;
            }
            .toolbar-right { flex: 1; justify-content: flex-end; }
            .search-container { position: relative; display: flex; align-items: center; width: clamp(240px, 40vw, 360px); }
            .search-icon { position: absolute; left: 12px; color: #666; font-size: 0.9rem; z-index: 1; }
            .search-input { width: 100%; padding: 10px 40px 10px 35px; border: 2px solid #ddd; border-radius: 8px; font-size: 0.9rem; background: #fff; transition: all 0.3s ease; }
            .search-input:focus { outline: none; border-color: #CC0052; box-shadow: 0 0 0 3px rgba(204, 0, 82, 0.1); }
            .clear-search { position: absolute; right: 8px; background: none; border: none; color: #666; cursor: pointer; padding: 4px; border-radius: 4px; transition: all 0.2s ease; display: none; }
            .clear-search:hover { background: #f0f0f0; color: #333; }

            .filter-sort {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                padding: 10px 16px;
                background: #ffffff;
                color: #111827;
                border-radius: 8px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 1px 2px rgba(0,0,0,0.06);
                font-weight: 600;
                cursor: pointer;
            }

            .filter-sort i { color: #6b7280; }

            /* Filter & Sort Panel */
            .hidden { display: none; }
            .filter-sort-panel {
                background: #ffffff;
                border: 1px solid #e5e7eb;
                border-top: none;
                box-shadow: 0 8px 24px rgba(0,0,0,0.08);
                padding: 16px 18px;
                position: sticky;
                top: 60px; /* below header */
                z-index: 1;
            }
            .panel-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 12px;
            }
            .panel-item { display: flex; flex-direction: column; gap: 6px; }
            .panel-label { font-size: 12px; font-weight: 700; color: #374151; text-transform: uppercase; letter-spacing: 0.5px; }
            .panel-actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 12px; }

            /* Table Styles */
            .table-container {
                overflow-x: auto;
                overflow-y: auto;
                margin: 0;
                height: calc(100vh - 60px - 96px - 56px);
                min-height: 0;
            }

            .participants-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.85rem;
                table-layout: auto;
                word-wrap: break-word;
                border: 1px solid #ddd;
            }

            .participants-table th {
                background: #f5f5f5;
                color: #333;
                padding: 10px 12px;
                text-align: left;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.8rem;
                letter-spacing: 0.4px;
                border: 1px solid #ddd;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .participants-table thead th {
                position: sticky;
                top: 0;
                z-index: 2;
            }

            .participants-table th:nth-child(7) {
                text-align: center;
                width: 120px;
            }
            /* Actions column: compact width */

            .participants-table td {
                padding: 10px 12px;
                border: 1px solid #ddd;
                vertical-align: middle;
                text-align: center;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                color: #555;
            }

            .participants-table td:not(:nth-child(7)) {
                text-align: left;
            }

            /* Ensure displayed text starts with a capital letter for key columns */
            .participants-table td:nth-child(3), /* Full Name */
            .participants-table td:nth-child(5), /* Gender */
            .participants-table td:nth-child(6)  /* Barangay */ {
                text-transform: capitalize;
            }

            /* Specific styling for attendance column */
            .participants-table td:nth-child(7) {
                text-align: center;
                vertical-align: middle;
                padding: 8px 4px;
                width: 120px;
            }

            .participants-table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .participants-table tbody tr:nth-child(even) {
                background-color: #fafafa;
            }

            /* Compact actions cell */

            /* Make delete button smaller inside table */

            /* Attendance Toggle Switch */
            .attendance-toggle {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                height: 40px;
            }

            .toggle-label {
                font-size: 12px;
                color: #374151;
                font-weight: 600;
            }

            .switch {
                position: relative;
                display: inline-block;
                width: 54px;
                height: 28px;
            }

            .switch input { display: none; }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0; left: 0; right: 0; bottom: 0;
                background-color: #e5e7eb;
                transition: 0.2s ease;
                border-radius: 999px;
                box-shadow: inset 0 0 0 1px #d1d5db;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 22px; width: 22px;
                left: 3px; top: 3px;
                background-color: #ffffff;
                transition: 0.2s ease;
                border-radius: 999px;
                box-shadow: 0 1px 3px rgba(17, 24, 39, 0.2);
            }

            .attendance-toggle-input:checked + .slider {
                background-color: #22c55e; /* green when ON */
                box-shadow: inset 0 0 0 1px #16a34a;
            }

            .attendance-toggle-input:checked + .slider:before {
                transform: translateX(26px);
            }

            /* Statistics */
            .participants-stats {
                background: #f8f9fa;
                padding: 20px 30px;
                border-top: 1px solid #e0e0e0;
                display: flex;
                gap: 40px;
                flex-wrap: wrap;
            }

            .stat-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 5px;
            }

            .stat-label {
                font-size: 12px;
                color: #666;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-value {
                font-size: 24px;
                font-weight: 700;
                color: #e31575;
            }

            /* Buttons */
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-primary {
                background: var(--accent-2);
                color: white;
            }

            .btn-primary:hover {
                background: #c41e3a;
            }

            .btn-danger {
                background: #dc3545;
                color: white;
                padding: 8px 12px;
            }

            .btn-danger:hover {
                background: #c82333;
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #545b62;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
            }

            .modal-content {
                background-color: white;
                margin: 5% auto;
                padding: 0;
                border-radius: 12px;
                width: 90%;
                max-width: 500px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .modal-header {
                background: #e31575;
                color: white;
                padding: 20px 30px;
                border-radius: 12px 12px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-header h3 {
                margin: 0;
                font-size: 18px;
                font-weight: 600;
            }

            .close {
                color: white;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
                line-height: 1;
            }

            .close:hover {
                opacity: 0.7;
            }

            .modal-body {
                padding: 30px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
            }

            .form-control {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e0e0e0;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                outline: none;
                border-color: #e31575;
                box-shadow: 0 0 0 3px rgba(227, 21, 117, 0.1);
            }

            .modal-actions {
                display: flex;
                justify-content: flex-end;
                gap: 15px;
                margin-top: 20px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .main {
                    margin-left: 0;
                    padding: 0;
                }
                
                .event-details {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .section-header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                }
                
                .header-left {
                    flex-direction: column;
                    gap: 15px;
                    align-items: center;
                }
                
                .participants-stats {
                    justify-content: center;
                }
                
                .participants-table {
                    font-size: 12px;
                }
                
                .participants-table th,
                .participants-table td {
                    padding: 10px 8px;
                }
                
                .attendance-radio {
                    gap: 10px;
                }
            }
        </style>

        <script>
            (function(){
                var input=document.getElementById('participantsSearchInput');
                var clearBtn=document.getElementById('participantsClear');
                if(!input) return;
                function rows(){ return Array.from(document.querySelectorAll('.participants-table tbody tr')); }
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
            // Attendance toggle functionality
            document.addEventListener('DOMContentLoaded', function() {
                const toggles = document.querySelectorAll('.attendance-toggle-input');

                toggles.forEach(toggle => {
                    toggle.addEventListener('change', function() {
                        const eventId = this.dataset.eventId;
                        const seniorId = this.dataset.seniorId;
                        const attended = this.checked;

                        this.disabled = true;

                        fetch(`/Events/${eventId}/participants/${seniorId}/attendance`, {
                            method: 'PUT',
                            headers: {
                                'Content-Type': 'application/json',
                                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                            },
                            body: JSON.stringify({ attended })
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                updateStatistics();
                            } else {
                                this.checked = !attended; // revert
                                alert('Error updating attendance: ' + (data.message || 'Unknown error'));
                            }
                        })
                        .catch(error => {
                            this.checked = !attended;
                            alert('Error updating attendance. Please try again.');
                            console.error('Error:', error);
                        })
                        .finally(() => {
                            this.disabled = false;
                        });
                    });
                });
            });

            // Update statistics
            function updateStatistics() {
                // Reload the page to update statistics
                // In a real application, you might want to update via AJAX
                setTimeout(() => {
                    location.reload();
                }, 1000);
            }

            // Remove participant
            function removeParticipant(eventId, seniorId) {
                if (confirm('Are you sure you want to remove this participant?')) {
                    fetch(`/Events/${eventId}/participants/${seniorId}`, {
                        method: 'DELETE',
                        headers: {
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        }
                    })
                    .then(response => {
                        if (response.ok) {
                            location.reload();
                        } else {
                            alert('Error removing participant. Please try again.');
                        }
                    })
                    .catch(error => {
                        alert('Error removing participant. Please try again.');
                        console.error('Error:', error);
                    });
                }
            }

            // Modal functions
            function openAddParticipantModal() {
                document.getElementById('addParticipantModal').style.display = 'block';
            }

            function closeAddParticipantModal() {
                document.getElementById('addParticipantModal').style.display = 'none';
                document.getElementById('addParticipantForm').reset();
            }

            // Close modal when clicking outside
            window.onclick = function(event) {
                const modal = document.getElementById('addParticipantModal');
                if (event.target === modal) {
                    closeAddParticipantModal();
                }
            }
        </script>
    </x-header>
</x-sidebar>
