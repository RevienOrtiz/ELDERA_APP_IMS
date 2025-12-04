<x-sidebar>
    <x-header title="Edit Event" icon="fas fa-calendar-edit">
        @include('message.popup_message')
        <div class="main">
            <div class="form-container">
                <div class="form-header">
                    <h2 class="form-title">Edit Event</h2>
                    <div class="form-subtitle">{{ $event->title }}</div>
                </div>

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
                <form method="POST" action="{{ route('events.update', $event->id) }}" class="event-form">
                    @csrf
                    @method('PUT')

                    @if($errors->any())
                        <div class="alert alert-danger">
                            @foreach($errors->all() as $error)
                                <div>{{ $error }}</div>
                            @endforeach
                        </div>
                    @endif

                    <div class="form-section">
                        <h3 class="section-title">Event Information</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="title" class="form-label">Event Title *</label>
                                <input type="text" id="title" name="title" class="form-control" 
                                       value="{{ old('title', $event->title) }}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="description" class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" 
                                          rows="3">{{ old('description', $event->description) }}</textarea>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="event_type" class="form-label">Event Type *</label>
                                <select id="event_type" name="event_type" class="form-control" required>
                                    <option value="">Select Event Type</option>
                                    <option value="general" {{ old('event_type', $event->event_type) == 'general' ? 'selected' : '' }}>General Meeting</option>
                                    <option value="pension" {{ old('event_type', $event->event_type) == 'pension' ? 'selected' : '' }}>Pension Distribution</option>
                                    <option value="health" {{ old('event_type', $event->event_type) == 'health' ? 'selected' : '' }}>Health Check-up</option>
                                    <option value="id_claiming" {{ old('event_type', $event->event_type) == 'id_claiming' ? 'selected' : '' }}>ID Claiming</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="status" class="form-label">Event Status *</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="upcoming" {{ old('status', $event->status) == 'upcoming' ? 'selected' : '' }}>Upcoming</option>
                                    <option value="ongoing" {{ old('status', $event->status) == 'ongoing' ? 'selected' : '' }}>Ongoing</option>
                                    <option value="completed" {{ old('status', $event->status) == 'completed' ? 'selected' : '' }}>Completed</option>
                                    <option value="cancelled" {{ old('status', $event->status) == 'cancelled' ? 'selected' : '' }}>Cancelled</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Date & Time</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="event_date" class="form-label">Event Date *</label>
                                <input type="date" id="event_date" name="event_date" class="form-control" 
                                       value="{{ old('event_date', $event->event_date->format('Y-m-d')) }}" required>
                            </div>
                            <div class="form-group">
                                <label for="start_time" class="form-label">Start Time *</label>
                                <input type="time" id="start_time" name="start_time" class="form-control" 
                                       value="{{ old('start_time', (function($t){ if($t instanceof \Carbon\CarbonInterface) return $t->format('H:i'); if(is_string($t) && $t!==''){ try { return \Carbon\Carbon::createFromFormat('H:i:s',$t)->format('H:i'); } catch (\Throwable $e) { return ''; } } return ''; })($event->start_time)) }}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="end_time" class="form-label">End Time</label>
                                <input type="time" id="end_time" name="end_time" class="form-control" 
                                       value="{{ old('end_time', (function($t){ if($t instanceof \Carbon\CarbonInterface) return $t->format('H:i'); if(is_string($t) && $t!==''){ try { return \Carbon\Carbon::createFromFormat('H:i:s',$t)->format('H:i'); } catch (\Throwable $e) { return ''; } } return ''; })($event->end_time)) }}">
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Location & Contact</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="location" class="form-label">Location *</label>
                                <input type="text" id="location" name="location" class="form-control" 
                                       value="{{ old('location', $event->location) }}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="organizer" class="form-label">Organizer</label>
                                <input type="text" id="organizer" name="organizer" class="form-control" 
                                       value="{{ old('organizer', $event->organizer) }}">
                            </div>
                            <div class="form-group">
                                <label for="contact_person" class="form-label">Contact Person</label>
                                <input type="text" id="contact_person" name="contact_person" class="form-control" 
                                       value="{{ old('contact_person', $event->contact_person) }}">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="contact_number" class="form-label">Contact Number</label>
                                <input type="text" id="contact_number" name="contact_number" class="form-control" 
                                       value="{{ old('contact_number', $event->contact_number) }}">
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Target Recipients Selection</h3>
                        <div class="d-flex flex-column gap-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_all" name="recipientTypes[]" value="all" class="form-check-input" {{ in_array('all', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_all" class="form-check-label">All Senior Citizens</label>
                                    </div>
                                    <p class="text-muted small mb-0 ms-4">Send notification to every registered senior citizen</p>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_barangay" name="recipientTypes[]" value="barangay" class="form-check-input" {{ in_array('barangay', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_barangay" class="form-check-label">Filter by Barangay</label>
                                    </div>
                                    <p class="text-muted small mb-3 ms-4">Send notification to seniors in selected barangay(s)</p>
                                    <div id="barangaySelection" class="ms-4" style="display: {{ in_array('barangay', $selectedTypes) ? 'block' : 'none' }};">
                                        <h6 class="mb-3">Select Barangays</h6>
                                        <div class="row g-2">
                                            <div class="col-12 mb-2">
                                                <div class="form-check">
                                                    <input type="checkbox" id="barangay_all" name="selectedBarangays[]" value="all" class="form-check-input" {{ in_array('all', $selectedBarangays) ? 'checked' : '' }}>
                                                    <label for="barangay_all" class="form-check-label">All Barangays</label>
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
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_category" name="recipientTypes[]" value="category" class="form-check-input" {{ in_array('category', $selectedTypes) ? 'checked' : '' }}>
                                        <label for="recipients_category" class="form-check-label">Filter by Category</label>
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
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Participants & Requirements</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <!-- Max participants option removed -->
                            </div>
                            <div class="form-group">
                                <label class="form-label">Current Participants</label>
                                <input type="text" class="form-control" value="{{ $event->current_participants }}" readonly>
                                <small class="form-text">Read-only field - managed automatically</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Created By</label>
                                <input type="text" class="form-control" value="{{ $event->createdBy->name ?? 'Unknown User' }}" readonly>
                                <small class="form-text">Read-only field</small>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Created At</label>
                                <input type="text" class="form-control" value="{{ $event->created_at->format('M d, Y g:i A') }}" readonly>
                                <small class="form-text">Read-only field</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="requirements" class="form-label">Requirements</label>
                                <textarea id="requirements" name="requirements" class="form-control" 
                                          rows="3">{{ old('requirements', $event->requirements) }}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="window.location.href='{{ route('events.show', $event->id) }}'">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Event
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <style>
            .main {
                margin-left: 250px;
                margin-top: 60px;
                min-height: calc(100vh - 60px);
                padding: 24px;
                background: #f8f9fa;
                display: flex;
                align-items: flex-start;
                justify-content: center;
            }

            .form-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                overflow: hidden;
                width: 100%;
                max-width: 700px;
            }

            .form-header {
                background: #e31575;
                color: white;
                padding: 20px;
                display: flex;
                flex-direction: column;
                gap: 6px;
                border-bottom: 1px solid #e0e0e0;
            }

            .form-title {
                margin: 0;
                font-size: 20px;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-subtitle {
                font-size: 14px;
                opacity: 0.9;
            }

            .back-btn {
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                border: 2px solid white;
                border-radius: 6px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 600;
            }

            .back-btn:hover {
                background: white;
                color: #e31575;
                text-decoration: none;
            }

            .event-form {
                padding: 20px;
            }

            .form-section {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e0e0e0;
            }

            .form-section:last-child {
                border-bottom: none;
            }

            .section-title {
                color: #e31575;
                font-size: 16px;
                font-weight: 700;
                margin-bottom: 16px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-row .form-group:only-child {
                grid-column: 1 / -1;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 6px;
                font-size: 13px;
            }

            .form-control {
                padding: 10px 14px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.2s ease;
                background: white;
            }

            .form-control:focus {
                outline: none;
                border-color: #e31575;
                box-shadow: 0 0 0 3px rgba(227, 21, 117, 0.1);
            }

            .form-control[readonly] {
                background-color: #f8f9fa;
                color: #6c757d;
            }

            .form-text {
                font-size: 12px;
                color: #666;
                margin-top: 5px;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 6px;
            }

            .alert-danger {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                margin-top: 10px;
                padding-top: 16px;
                border-top: 1px solid #e0e0e0;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #545b62;
            }

            .btn-primary {
                background: #e31575;
                color: white;
                border: 2px solid #e31575;
                border-radius: 25px;
                padding: 10px 20px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-primary:hover {
                background: #c41e3a;
            }
            .card { border: 1px solid #eee; border-radius: 10px; }
            .card-body { padding: 16px; }

            @media (max-width: 768px) {
                .main {
                    margin-left: 0;
                    padding: 16px;
                }
                
                .form-header {
                    text-align: left;
                }
                
                .form-row {
                    grid-template-columns: 1fr;
                }
                
                .form-actions {
                    flex-direction: column;
                }
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const recipientCheckboxes = document.querySelectorAll('input[name="recipientTypes[]"]');
                const barangaySelection = document.getElementById('barangaySelection');
                const categorySelection = document.getElementById('categorySelection');
                const allSeniorsCheckbox = document.getElementById('recipients_all');
                const barangayCheckbox = document.getElementById('recipients_barangay');
                const categoryCheckbox = document.getElementById('recipients_category');

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
            });
        </script>
    </x-header>
</x-sidebar>
