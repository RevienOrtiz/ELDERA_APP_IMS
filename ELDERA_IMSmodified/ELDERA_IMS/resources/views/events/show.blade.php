<x-sidebar>
    <x-header title="Event Details" icon="fas fa-calendar-check">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        @include('message.popup_message')
        @php
            $selection = is_array($event->recipient_selection) ? $event->recipient_selection : json_decode($event->recipient_selection ?? '[]', true);
            $selectedTypes = isset($selection['types']) && is_array($selection['types']) ? $selection['types'] : [];
            $selectedBarangays = isset($selection['barangays']) && is_array($selection['barangays']) ? $selection['barangays'] : [];
            $selectedCategories = isset($selection['categories']) && is_array($selection['categories']) ? $selection['categories'] : [];
            if (empty($selectedTypes)) {
                if ($event->event_type === 'id_claiming') {
                    $selectedTypes = ['category'];
                    $selectedCategories = ['id_applicants'];
                } elseif ($event->event_type === 'pension') {
                    $selectedTypes = ['category'];
                    $selectedCategories = ['pension'];
                }
            }
        @endphp
        <div class="main">
            <div class="event-details-container {{ $event->event_type }} {{ $event->computed_status }}">
                <!-- Event Header -->
                <div class="event-header">
                    <div class="header-left">
                        <h1 class="event-title">{{ $event->title }}</h1>
                    </div>
                    <div class="header-right">
                        <a href="{{ route('events.participants', $event->id) }}" class="participants-btn">
                            <i class="fas fa-users"></i> Manage Participants
                        </a>
                        @if($event->status === 'upcoming')
                            <a href="#" class="icon-btn" id="openEditModalBtn" title="Edit Event" aria-label="Edit Event">
                                <i class="fas fa-edit"></i>
                            </a>
                        @endif
                        <button class="icon-btn icon-danger" onclick="deleteEvent('{{ $event->id }}')" title="Delete Event" aria-label="Delete Event">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>

                <!-- Event Content -->
                <div class="event-content">
                    <div class="content-left">
                        <!-- Event Information -->
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-info-circle"></i>
                                Event Information
                            </h3>
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Date & Time</label>
                                    <div class="info-value">
                                        <i class="fas fa-calendar"></i>
                                        {{ $event->formatted_date_time }}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <label>Location</label>
                                    <div class="info-value">
                                        <i class="fas fa-map-marker-alt"></i>
                                        {{ $event->location }}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <label>Organizer</label>
                                    <div class="info-value">
                                        <i class="fas fa-user-tie"></i>
                                        {{ $event->organizer }}
                                    </div>
                                </div>
                                <div class="info-item">
                                    <label>Contact Person</label>
                                    <div class="info-value">
                                        <i class="fas fa-phone"></i>
                                        {{ $event->contact_person }} - {{ $event->contact_number }}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Description -->
                        @if($event->description)
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-align-left"></i>
                                Description
                            </h3>
                            <div class="description-content" style="background:#fbf7f2;border:1px solid #ececec;border-radius:12px;padding:16px;box-shadow:0 1px 2px rgba(17,24,39,0.06);color:#111827;font-weight:500;">
                                {{ $event->description }}
                            </div>
                        </div>
                        @endif

                        <!-- Requirements -->
                        @if($event->requirements)
                        <div class="info-section">
                            <h3 class="section-title">
                                <i class="fas fa-clipboard-list"></i>
                                Requirements
                            </h3>
                            <div class="requirements-content">
                                {{ $event->requirements }}
                            </div>
                        </div>
                        @endif
                    </div>

                    <div class="content-right"></div>
                </div>
            </div>
        </div>
        
        

        <style>
            .main {
                margin-left: 250px;
                margin-top: 60px;
                height: calc(100vh - 60px);
                min-height: calc(100vh - 60px);
                padding: 0;
                background: #f3f4f6;
                overflow: hidden; /* ensure only inner content scrolls */
            }

            .event-details-container {
                background: #ffffff;
                border-radius: 0;
                border: none;
                box-shadow: none;
                overflow: hidden;
                width: 100%;
                margin: 0;
                height: 100%;
                display: flex;
                flex-direction: column; /* header + scrollable content */
            }

            /* Dynamic event color mapping via CSS variables */
            /* General = Green, Pension = Blue, Health = Red, ID Claiming = Yellow */
            .event-details-container.general { --accent-1: #86efac; --accent-2: #22c55e; --accent-btn: #16a34a; }
            .event-details-container.pension { --accent-1: #93c5fd; --accent-2: #3b82f6; --accent-btn: #1d4ed8; }
            .event-details-container.health { --accent-1: #fca5a5; --accent-2: #ef4444; --accent-btn: #b91c1c; }
            .event-details-container.id_claiming { --accent-1: #fde68a; --accent-2: #f59e0b; --accent-btn: #d97706; }
            .event-details-container.done { --accent-1: #d1d5db; --accent-2: #6b7280; --accent-btn: #4b5563; }
            /* Fallback */
            .event-details-container { --accent-1: #f9a8d4; --accent-2: #e31575; --accent-btn: #c01060; }

            .event-header {
                background: var(--accent-2);
                color: #ffffff;
                padding: 18px 24px; /* slightly larger to match Add Senior */
                display: flex;
                justify-content: space-between;
                align-items: center; /* center vertically for toolbar look */
                position: sticky; /* keep header fixed at top */
                top: 0;
                z-index: 3;
                overflow: hidden;
                min-height: 68px; /* closer to Add New Senior header */
            }

            /* Accent underline similar to screenshot */
            .event-header::after {
                content: "";
                position: absolute;
                left: 0;
                right: 0;
                bottom: 0;
                height: 3px; /* slimmer accent underline */
                background: var(--accent-2);
                opacity: 0.95;
            }

            .event-title {
                margin: 0; /* remove extra bottom gap */
                font-size: 24px; /* match toolbar headline size */
                font-weight: 800;
                letter-spacing: 0.2px;
            }

            .event-meta {
                display: flex;
                gap: 10px;
                align-items: center;
                flex-wrap: wrap;
            }

            .event-type, .event-status {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 6px 12px;
                border-radius: 999px;
                font-size: 13px;
                font-weight: 700;
                letter-spacing: 0.3px;
                border: 1px solid rgba(255, 255, 255, 0.35);
                background: rgba(255, 255, 255, 0.15);
            }

            .event-type.general { background: rgba(0, 123, 255, 0.2); }
            .event-type.pension { background: rgba(40, 167, 69, 0.2); }
            .event-type.health { background: rgba(220, 53, 69, 0.2); }
            .event-type.id_claiming { background: rgba(255, 193, 7, 0.2); }

            .event-status.upcoming { background: rgba(255, 193, 7, 0.2); }
            .event-status.ongoing { background: rgba(40, 167, 69, 0.2); }
            .event-status.completed { background: rgba(108, 117, 125, 0.2); }
            .event-status.cancelled { background: rgba(220, 53, 69, 0.2); }
            .event-status.done { background: rgba(108, 117, 125, 0.25); }

            .header-right {
                display: flex;
                gap: 15px;
                align-items: center;
            }

            .back-btn, .edit-btn {
                color: #ffffff;
                text-decoration: none;
                padding: 10px 18px;
                border: 1px solid rgba(255, 255, 255, 0.35);
                border-radius: 8px;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 600;
                background: var(--accent-btn);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

            .back-btn:hover, .edit-btn:hover, .participants-btn:hover {
                background: var(--accent-2);
                color: #ffffff;
                text-decoration: none;
                box-shadow: 0 8px 16px rgba(16, 24, 40, 0.25);
            }

            .participants-btn {
                color: #ffffff;
                text-decoration: none;
                padding: 10px 18px;
                border: 1px solid rgba(255, 255, 255, 0.35);
                border-radius: 8px;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 600;
                background: var(--accent-btn);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

            .icon-btn {
                color: #ffffff;
                text-decoration: none;
                width: 36px;
                height: 36px;
                border: 1px solid rgba(255, 255, 255, 0.35);
                border-radius: 50%;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: var(--accent-btn);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                font-size: 16px;
            }
            .icon-btn.icon-danger { background: #dc3545; border-color: rgba(255,255,255,0.35); }
            .icon-btn:hover { background: var(--accent-2); color: #ffffff; }
            .icon-btn.icon-danger:hover { background: #c82333; }

            .event-content {
                display: grid;
                grid-template-columns: 1fr;
                gap: 32px;
                padding: 32px;
                flex: 1;
                min-height: 0;
                overflow-y: auto;
            }

            .info-section { margin-bottom: 24px; }

            .section-title {
                color: #374151;
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 12px;
                padding-bottom: 10px;
                border-bottom: 1px solid #e5e7eb;
                display: flex;
                align-items: center;
                gap: 10px;
                letter-spacing: 0.1px;
            }

            .info-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }

            .info-item {
                background: #fbf7f2;
                padding: 16px;
                border-radius: 12px;
                border: 1px solid #ececec;
                box-shadow: 0 1px 2px rgba(17, 24, 39, 0.06);
            }

            .info-item label { display: block; font-weight: 700; color: #6b7280; margin-bottom: 6px; font-size: 13px; letter-spacing: 0.1px; }
            .info-value { font-weight: 600; color: #111827; }

            .info-value {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 15px;
                color: #1f2937;
            }

            .description-content, .requirements-content {
                background: #ffffff;
                padding: 18px;
                border-radius: 10px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 2px 8px rgba(17, 24, 39, 0.05);
                border-left: 4px solid #e31575;
                line-height: 1.65;
            }

            .participants-section {
                background: #ffffff;
                padding: 24px;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 2px 8px rgba(17, 24, 39, 0.05);
                margin-bottom: 20px;
            }

            .participants-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
                gap: 16px;
                margin-bottom: 16px;
            }

            .stat-item {
                text-align: center;
                background: #ffffff;
                padding: 16px;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 1px 6px rgba(17, 24, 39, 0.06);
            }

            .stat-number {
                display: block;
                font-size: 22px;
                font-weight: 800;
                color: #c01060;
            }

            .stat-label {
                font-size: 12px;
                color: #6b7280;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .participants-list h4 {
                margin-bottom: 12px;
                color: #1f2937;
                font-weight: 700;
            }

            .participants-grid {
                max-height: 300px;
                overflow-y: auto;
                padding-right: 6px;
            }
            #eventModal .card { border: 1px solid #eee; border-radius: 10px; }
            #eventModal .card-body { padding: 16px; }

            .participant-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px;
                background: #ffffff;
                border-radius: 10px;
                margin-bottom: 8px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 1px 6px rgba(17, 24, 39, 0.06);
            }

            .participant-info strong {
                display: block;
                color: #111827;
                font-weight: 700;
            }

            .participant-info small {
                color: #6b7280;
                font-size: 12px;
            }

            .status-attended {
                color: #16a34a;
                font-size: 12px;
                font-weight: 700;
            }

            .status-registered {
                color: #f59e0b;
                font-size: 12px;
                font-weight: 700;
            }

            .no-participants {
                text-align: center;
                padding: 28px 16px;
                color: #6b7280;
            }

            .no-participants i {
                font-size: 44px;
                margin-bottom: 12px;
                opacity: 0.5;
            }

            .actions-section {
                background: #ffffff;
                padding: 24px;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
                box-shadow: 0 2px 8px rgba(17, 24, 39, 0.05);
            }

            .action-buttons {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 12px;
            }

            .action-btn {
                padding: 12px 18px;
                border: none;
                border-radius: 10px;
                font-weight: 700;
                cursor: pointer;
                transition: transform 0.1s ease, box-shadow 0.2s ease, background-color 0.2s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                justify-content: center;
                box-shadow: 0 1px 6px rgba(17, 24, 39, 0.08);
            }

            .ongoing-btn {
                background: #22c55e;
                color: #ffffff;
            }

            .ongoing-btn:hover {
                background: #16a34a;
                transform: translateY(-1px);
                box-shadow: 0 6px 14px rgba(34, 197, 94, 0.35);
            }

            .complete-btn {
                background: #06b6d4;
                color: #ffffff;
            }

            .complete-btn:hover {
                background: #0ea5b7;
                transform: translateY(-1px);
                box-shadow: 0 6px 14px rgba(6, 182, 212, 0.35);
            }

            .cancel-btn {
                background: #ffc107;
                color: #333;
            }

            .cancel-btn:hover {
                background: #e0a800;
                transform: translateY(-1px);
                box-shadow: 0 6px 14px rgba(255, 193, 7, 0.35);
            }

            .delete-btn {
                background: #ef4444;
                color: #ffffff;
            }

            .delete-btn:hover {
                background: #dc2626;
                transform: translateY(-1px);
                box-shadow: 0 6px 14px rgba(239, 68, 68, 0.35);
            }


            @media (max-width: 768px) {
                .main {
                    margin-left: 0;
                    padding: 12px;
                }
                
                .event-content {
                    grid-template-columns: 1fr;
                    gap: 20px;
                }
                
                .event-header {
                    flex-direction: column;
                    gap: 16px;
                }
                
                .header-right {
                    width: 100%;
                    justify-content: flex-start;
                }
                
                .info-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
        <div id="eventModal" style="display:none; position:fixed; z-index:1000; inset:0; width:100%; height:100%; background-color: rgba(0,0,0,0.5); align-items:center; justify-content:center; padding:24px;">
            <div class="modal-content" style="background-color:#fff; margin:0; padding:0; border-radius:10px; width:90%; max-width:600px; max-height:90vh; display:flex; flex-direction:column; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.15);">
                <div class="modal-header" style="display:flex; justify-content:space-between; align-items:center; padding:20px; border-bottom:1px solid #e0e0e0; background:#e31575; color:white; border-radius:8px 8px 0 0; position:sticky; top:0; z-index:2;">
                    <h2 style="margin:0; color:white; font-size:18px; font-weight:600;">EDIT EVENT</h2>
                    <button id="closeEditModalBtn" style="background:none; border:none; font-size:24px; cursor:pointer; color:white; padding:5px; border-radius:4px;">×</button>
                </div>
                <div class="modal-body" style="flex:1; overflow-y:auto; min-height:0;">
                    <form class="event-form" id="editEventForm" style="padding:20px;">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="eventTitle" class="form-label fw-semibold">Event Title</label>
                                <input type="text" class="form-control" id="eventTitle" value="{{ old('title', $event->title) }}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="eventType" class="form-label fw-semibold">Event Type</label>
                                <select class="form-select" id="eventType" required>
                                    <option value="">Select Event Type</option>
                                    <option value="general" {{ old('event_type', $event->event_type) == 'general' ? 'selected' : '' }}>General</option>
                                    <option value="pension" {{ old('event_type', $event->event_type) == 'pension' ? 'selected' : '' }}>Pension</option>
                                    <option value="health" {{ old('event_type', $event->event_type) == 'health' ? 'selected' : '' }}>Health-related</option>
                                    <option value="id_claiming" {{ old('event_type', $event->event_type) == 'id_claiming' ? 'selected' : '' }}>ID Claiming</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="eventStatus" class="form-label fw-semibold">Event Status</label>
                                <select class="form-select" id="eventStatus" required>
                                    <option value="upcoming" {{ old('status', $event->status) == 'upcoming' ? 'selected' : '' }}>Upcoming</option>
                                    <option value="ongoing" {{ old('status', $event->status) == 'ongoing' ? 'selected' : '' }}>Ongoing</option>
                                    <option value="completed" {{ old('status', $event->status) == 'completed' ? 'selected' : '' }}>Completed</option>
                                    <option value="cancelled" {{ old('status', $event->status) == 'cancelled' ? 'selected' : '' }}>Cancelled</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="eventDate" class="form-label fw-semibold">Date</label>
                                <input type="date" class="form-control" id="eventDate" value="{{ old('event_date', $event->event_date->format('Y-m-d')) }}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="eventTime" class="form-label fw-semibold">Time</label>
                                <input type="time" class="form-control" id="eventTime" value="{{ old('start_time', $event->start_time->format('H:i')) }}" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="eventEndTime" class="form-label fw-semibold">End Time</label>
                                <input type="time" class="form-control" id="eventEndTime" value="{{ old('end_time', $event->end_time ? $event->end_time->format('H:i') : '') }}">
                            </div>
                            <div class="col-md-6"></div>
                        </div>
                        <div class="mb-3">
                            <label for="eventDescription" class="form-label fw-semibold">Description</label>
                            <textarea class="form-control" id="eventDescription" rows="3">{{ old('description', $event->description) }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="eventRequirements" class="form-label fw-semibold">Requirements</label>
                            <textarea class="form-control" id="eventRequirements" rows="3">{{ old('requirements', $event->requirements) }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="eventLocation" class="form-label fw-semibold">Location</label>
                            <input type="text" class="form-control" id="eventLocation" value="{{ old('location', $event->location) }}">
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="eventOrganizer" class="form-label fw-semibold">Organizer</label>
                                <input type="text" class="form-control" id="eventOrganizer" value="{{ old('organizer', $event->organizer) }}">
                            </div>
                            <div class="col-md-6">
                                <label for="eventContactPerson" class="form-label fw-semibold">Contact Person</label>
                                <input type="text" class="form-control" id="eventContactPerson" value="{{ old('contact_person', $event->contact_person) }}">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="eventContactNumber" class="form-label fw-semibold">Contact Number</label>
                            <input type="text" class="form-control" id="eventContactNumber" value="{{ old('contact_number', $event->contact_number) }}">
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Target Recipients Selection</label>
                            <p class="text-muted small mb-3">Choose who should receive notifications for this event</p>
                            <div class="d-flex flex-column gap-3">
                                <div class="card"><div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_all" name="recipientTypes[]" value="all" class="form-check-input" {{ in_array('all', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_all" class="form-check-label fw-semibold">All Senior Citizens</label>
                                    </div>
                                    <p class="text-muted small mb-0 ms-4">Send notification to every registered senior citizen</p>
                                </div></div>
                                <div class="card"><div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_barangay" name="recipientTypes[]" value="barangay" class="form-check-input" {{ in_array('barangay', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_barangay" class="form-check-label fw-semibold">Filter by Barangay</label>
                                    </div>
                                    <p class="text-muted small mb-3 ms-4">Send notification to seniors in selected barangay(s)</p>
                                    <div id="barangaySelection" class="ms-4" style="display: {{ in_array('barangay', $selectedTypes) ? 'block' : 'none' }};">
                                        <h6 class="mb-3">Select Barangays</h6>
                                        <div class="row g-2">
                                            <div class="col-12 mb-2">
                                                <div class="form-check">
                                                    <input type="checkbox" id="barangay_all" name="selectedBarangays[]" value="all" class="form-check-input" {{ in_array('all', $selectedBarangays) ? 'checked' : '' }}>
                                                    <label for="barangay_all" class="form-check-label fw-semibold">All Barangays</label>
                                                </div>
                                            </div>
                                            @foreach([
                                                'aliwekwek', 'baay', 'balangobong', 'balococ', 'bantayan', 'basing', 'capandanan',
                                                'domalandan-center', 'domalandan-east', 'domalandan-west', 'dorongan', 'dulag',
                                                'estanza', 'lasip', 'libsong-east', 'libsong-west', 'malawa', 'malimpuec',
                                                'maniboc', 'matalava', 'naguelguel', 'namolan', 'pangapisan-north', 'pangapisan-sur',
                                                'poblacion', 'quibaol', 'rosario', 'sabangan', 'talogtog', 'tonton', 'tumbar', 'wawa'
                                            ] as $barangay)
                                                <div class="col-md-4 col-sm-6">
                                                    <div class="form-check">
                                                        <input type="checkbox" id="barangay_{{ $barangay }}" name="selectedBarangays[]" value="{{ $barangay }}" class="form-check-input" {{ in_array($barangay, $selectedBarangays) ? 'checked' : '' }}>
                                                        <label for="barangay_{{ $barangay }}" class="form-check-label">{{ ucwords(str_replace('-', ' ', $barangay)) }}</label>
                                                    </div>
                                                </div>
                                            @endforeach
                                        </div>
                                    </div>
                                </div></div>
                                <div class="card"><div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_category" name="recipientTypes[]" value="category" class="form-check-input" {{ in_array('category', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_category" class="form-check-label fw-semibold">Filter by Category</label>
                                    </div>
                                    <p class="text-muted small mb-3 ms-4">Auto-select seniors based on system records</p>
                                    <div id="categorySelection" class="ms-4" style="display: {{ in_array('category', $selectedTypes) ? 'block' : 'none' }};">
                                        <h6 class="mb-3">Select Categories</h6>
                                        <div class="d-flex flex-column gap-2">
                                            <div class="form-check">
                                                <input type="checkbox" id="category_pension" name="selectedCategories[]" value="pension" class="form-check-input" {{ in_array('pension', $selectedCategories) ? 'checked' : '' }}>
                                                <label for="category_pension" class="form-check-label"><strong>Pension Recipients</strong><br><small class="text-muted">Seniors listed in the pension table</small></label>
                                            </div>
                                            <div class="form-check">
                                                <input type="checkbox" id="category_id" name="selectedCategories[]" value="id_applicants" class="form-check-input" {{ in_array('id_applicants', $selectedCategories) ? 'checked' : '' }}>
                                                <label for="category_id" class="form-check-label"><strong>ID Applicants</strong><br><small class="text-muted">Seniors from the ID application table</small></label>
                                            </div>
                                            <div class="form-check">
                                                <input type="checkbox" id="category_benefits" name="selectedCategories[]" value="benefit_applicants" class="form-check-input" {{ in_array('benefit_applicants', $selectedCategories) ? 'checked' : '' }}>
                                                <label for="category_benefits" class="form-check-label"><strong>Benefit Applicants</strong><br><small class="text-muted">Seniors from the benefits table</small></label>
                                            </div>
                                        </div>
                                    </div>
                                </div></div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                            <button type="button" class="btn btn-secondary" id="cancelEditEventBtn">Cancel</button>
                            <button type="submit" class="btn btn-primary" style="background-color:#e31575; border-color:#e31575;">Update Event</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            let currentAction = null;
            let currentEventId = null;

            function updateEventStatus(eventId, status) {
                console.log('updateEventStatus called with:', eventId, status);
                currentAction = 'updateStatus';
                currentEventId = eventId;
                
                const statusMessages = {
                    'ongoing': 'mark this event as ongoing?',
                    'completed': 'mark this event as completed?',
                    'cancelled': 'cancel this event?'
                };
                
                document.getElementById('eventConfirmTitle').textContent = 'Confirm Status Change';
                document.getElementById('eventConfirmMessage').textContent = `Are you sure you want to ${statusMessages[status]}`;
                document.getElementById('eventConfirmBtn').textContent = 'Confirm';
                
                // Set button color based on status
                if (status === 'ongoing') {
                    document.getElementById('eventConfirmBtn').className = 'btn btn-success w-50';
                } else if (status === 'cancelled') {
                    document.getElementById('eventConfirmBtn').className = 'btn btn-warning w-50';
                } else {
                    document.getElementById('eventConfirmBtn').className = 'btn btn-primary w-50';
                }
                
                // Store the status for the confirmation
                document.getElementById('eventConfirmBtn').dataset.status = status;
                
                const modal = new bootstrap.Modal(document.getElementById('eventConfirmModal'));
                modal.show();
            }

            function deleteEvent(eventId) {
                console.log('deleteEvent called with:', eventId);
                const title = 'Confirm Deletion';
                const message = 'Are you sure you want to delete this event? This action cannot be undone.';
                const actionUrl = `/Events/${eventId}`;
                const method = 'DELETE';
                
                if (typeof showConfirmModal === 'function') {
                    showConfirmModal(title, message, actionUrl, method);
                } else {
                    if (confirm('Are you sure you want to delete this event? This action cannot be undone.')) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = actionUrl;
                        const csrfToken = document.createElement('input');
                        csrfToken.type = 'hidden';
                        csrfToken.name = '_token';
                        csrfToken.value = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
                        const methodField = document.createElement('input');
                        methodField.type = 'hidden';
                        methodField.name = '_method';
                        methodField.value = method;
                        form.appendChild(csrfToken);
                        form.appendChild(methodField);
                        document.body.appendChild(form);
                        form.submit();
                    }
                }
            }

            function executeConfirmedAction() {
                if (currentAction === 'updateStatus') {
                    const status = document.getElementById('eventConfirmBtn').dataset.status;
                    fetch(`/Events/${currentEventId}`, {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        },
                        body: JSON.stringify({
                            status: status,
                            _method: 'PUT'
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            location.reload();
                        } else {
                            showErrorModal('Error updating event status');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showErrorModal('Error updating event status');
                    });
                } else if (currentAction === 'delete') {
                    fetch(`/Events/${currentEventId}`, {
                        method: 'DELETE',
                        headers: {
                            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        },
                        redirect: 'follow'
                    })
                    .then(response => {
                        // For DELETE requests that return redirects, we consider it successful
                        // The server will redirect to /Events with success message
                        // Force cache refresh by adding timestamp
                        window.location.href = '/Events?t=' + Date.now();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        showErrorModal('Error deleting event');
                    });
                }
                
                // Close the modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('eventConfirmModal'));
                if (modal) {
                    modal.hide();
                }
            }

            // Function to show error modal using the existing popup system
            function showErrorModal(message) {
                document.getElementById('errorMessage').innerText = message;
                const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
                errorModal.show();
            }

        </script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const modal = document.getElementById('eventModal');
                const openBtn = document.getElementById('openEditModalBtn');
                const closeBtn = document.getElementById('closeEditModalBtn');
                const cancelBtn = document.getElementById('cancelEditEventBtn');

                function openModal() { modal.style.display = 'flex'; document.body.style.overflow = 'hidden'; initializeRecipientSelection(); }
                function closeModal() { modal.style.display = 'none'; document.body.style.overflow = ''; }

                if (openBtn) openBtn.addEventListener('click', (e) => { e.preventDefault(); openModal(); });
                if (closeBtn) closeBtn.addEventListener('click', closeModal);
                if (cancelBtn) cancelBtn.addEventListener('click', closeModal);

                function initializeRecipientSelection() {
                    const recipientCheckboxes = document.querySelectorAll('input[name="recipientTypes[]"]');
                    const barangaySelection = document.getElementById('barangaySelection');
                    const categorySelection = document.getElementById('categorySelection');
                    const allSeniorsCheckbox = document.getElementById('recipients_all');
                    const barangayCheckbox = document.getElementById('recipients_barangay');
                    const categoryCheckbox = document.getElementById('recipients_category');
                    const allBarangaysCheckbox = document.getElementById('barangay_all');

                    // Do not auto-select any type; rely on prefilled selection
                    if (barangaySelection && barangayCheckbox) {
                        barangaySelection.style.display = barangayCheckbox.checked ? 'block' : 'none';
                    }
                    if (categorySelection && categoryCheckbox) {
                        categorySelection.style.display = categoryCheckbox.checked ? 'block' : 'none';
                    }

                    recipientCheckboxes.forEach(checkbox => {
                        checkbox.addEventListener('change', function() {
                            if (this.value === 'barangay') {
                                barangaySelection.style.display = this.checked ? 'block' : 'none';
                            } else if (this.value === 'category') {
                                categorySelection.style.display = this.checked ? 'block' : 'none';
                            }
                            if (this.value === 'all' && this.checked) {
                                barangayCheckbox.checked = false;
                                categoryCheckbox.checked = false;
                                barangaySelection.style.display = 'none';
                                categorySelection.style.display = 'none';
                            }
                            if ((this.value === 'barangay' || this.value === 'category') && this.checked) {
                                allSeniorsCheckbox.checked = false;
                            }
                        });
                    });
                    if (allBarangaysCheckbox) {
                        allBarangaysCheckbox.addEventListener('change', function() {
                            const barangayCheckboxes = document.querySelectorAll('input[name="selectedBarangays[]"]');
                            barangayCheckboxes.forEach(checkbox => { if (checkbox.value !== 'all') { checkbox.checked = this.checked; } });
                        });
                    }
                    const individualBarangayCheckboxes = document.querySelectorAll('input[name="selectedBarangays[]"][value!="all"]');
                    individualBarangayCheckboxes.forEach(checkbox => {
                        checkbox.addEventListener('change', function() { if (!this.checked && allBarangaysCheckbox) { allBarangaysCheckbox.checked = false; } });
                    });
                }

                function getRecipientSelectionData() {
                    const selectedTypes = [];
                    document.querySelectorAll('input[name="recipientTypes[]"]:checked').forEach(cb => selectedTypes.push(cb.value));
                    const data = { types: selectedTypes, barangays: [], categories: [] };
                    if (selectedTypes.includes('barangay')) {
                        document.querySelectorAll('input[name="selectedBarangays[]"]:checked').forEach(cb => data.barangays.push(cb.value));
                    }
                    if (selectedTypes.includes('category')) {
                        document.querySelectorAll('input[name="selectedCategories[]"]:checked').forEach(cb => data.categories.push(cb.value));
                    }
                    return data;
                }

                function validateRecipientSelection(recipientData) {
                    if (!recipientData.types || recipientData.types.length === 0) {
                        try { showValidationErrorModal('Validation Error', 'Please select at least one recipient type.'); } catch (_) {}
                        return false;
                    }
                    if (recipientData.types.includes('barangay')) {
                        if (!recipientData.barangays || recipientData.barangays.length === 0) {
                            try { showValidationErrorModal('Validation Error', 'Please select at least one barangay.'); } catch (_) {}
                            return false;
                        }
                    }
                    if (recipientData.types.includes('category')) {
                        if (!recipientData.categories || recipientData.categories.length === 0) {
                            try { showValidationErrorModal('Validation Error', 'Please select at least one category.'); } catch (_) {}
                            return false;
                        }
                    }
                    return true;
                }

                const form = document.getElementById('editEventForm');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        e.preventDefault();
                        const recipientData = getRecipientSelectionData();
                        if (!validateRecipientSelection(recipientData)) return;
                        const fd = new FormData();
                        fd.append('title', document.getElementById('eventTitle').value);
                        fd.append('event_type', document.getElementById('eventType').value);
                        fd.append('status', document.getElementById('eventStatus').value);
                        fd.append('event_date', document.getElementById('eventDate').value);
                        fd.append('start_time', document.getElementById('eventTime').value);
                        fd.append('end_time', document.getElementById('eventEndTime').value);
                        fd.append('description', document.getElementById('eventDescription').value);
                        fd.append('requirements', document.getElementById('eventRequirements').value);
                        fd.append('location', document.getElementById('eventLocation').value);
                        fd.append('organizer', document.getElementById('eventOrganizer').value);
                        fd.append('contact_person', document.getElementById('eventContactPerson').value);
                        fd.append('contact_number', document.getElementById('eventContactNumber').value);
                        fd.append('recipient_selection', JSON.stringify(recipientData));
                        fd.append('_token', document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
                        fetch('/Events/{{ $event->id }}', { method: 'PUT', body: fd, headers: { 'X-Requested-With': 'XMLHttpRequest', 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content') } })
                            .then(r => { if (!r.ok) { return r.json().then(err => { throw err; }).catch(() => { throw new Error('Server error'); }); } return r.json(); })
                            .then((data) => { 
                                try { window.showSuccessModal('Event successfully updated.', 'updated'); } catch (e) {}
                                setTimeout(() => { closeModal(); location.reload(); }, 1200);
                            })
                            .catch((err) => { try { const msg = (err && err.errors) ? 'Please check all required fields.' : 'Error updating event. Please try again.'; document.getElementById('errorMessage').innerText = msg; new bootstrap.Modal(document.getElementById('errorModal')).show(); } catch (_) {} });
                    });
                }
            });
        </script>
    </x-header>
</x-sidebar>
        <!-- Custom Confirmation Modal for Events -->
        <div class="modal fade" id="eventConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center p-4">
                    <div class="mb-3">
                        <div class="rounded-circle bg-warning d-inline-flex align-items-center justify-content-center" style="width:60px; height:60px;">
                            <i class="bi bi-exclamation-lg text-white fs-2"></i>
                        </div>
                    </div>
                    <h4 class="fw-bold text-warning" id="eventConfirmTitle">Are you sure?</h4>
                    <p id="eventConfirmMessage">Do you really want to proceed?</p>
                    <div class="d-flex gap-2 mt-3">
                        <button type="button" class="btn btn-secondary w-50" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-warning w-50" id="eventConfirmBtn" onclick="executeConfirmedAction()">Yes, Proceed</button>
                    </div>
                </div>
            </div>
        </div>
