<x-sidebar>
    <x-header title="Add New Event" icon="fas fa-calendar-plus">
        @include('message.popup_message')
        <div class="main">
            <div class="form-container">
                <div class="form-header">
                    <h2 class="form-title">Create New Event</h2>
                </div>

                <form method="POST" action="{{ route('events.store') }}" class="event-form">
                    @csrf

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
                                       value="{{ old('title') }}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="description" class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" 
                                          rows="3">{{ old('description') }}</textarea>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="event_type" class="form-label">Event Type *</label>
                                <select id="event_type" name="event_type" class="form-control" required>
                                    <option value="">Select Event Type</option>
                                    <option value="general" {{ old('event_type') == 'general' ? 'selected' : '' }}>General Meeting</option>
                                    <option value="pension" {{ old('event_type') == 'pension' ? 'selected' : '' }}>Pension Distribution</option>
                                    <option value="health" {{ old('event_type') == 'health' ? 'selected' : '' }}>Health Check-up</option>
                                    <option value="id_claiming" {{ old('event_type') == 'id_claiming' ? 'selected' : '' }}>ID Claiming</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="event_date" class="form-label">Event Date *</label>
                                <input type="date" id="event_date" name="event_date" class="form-control" 
                                       value="{{ old('event_date') }}" required>
                            </div>
                            <div class="form-group">
                                <label for="start_time" class="form-label">Start Time *</label>
                                <input type="time" id="start_time" name="start_time" class="form-control" 
                                       value="{{ old('start_time') }}" required>
                            </div>
                            <div class="form-group">
                                <label for="end_time" class="form-label">End Time</label>
                                <input type="time" id="end_time" name="end_time" class="form-control" 
                                       value="{{ old('end_time') }}">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="location" class="form-label">Location *</label>
                                <input type="text" id="location" name="location" class="form-control" 
                                       value="{{ old('location') }}" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Contact Information</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="organizer" class="form-label">Organizer *</label>
                                <input type="text" id="organizer" name="organizer" class="form-control" 
                                       value="{{ old('organizer') }}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="contact_person" class="form-label">Contact Person *</label>
                                <input type="text" id="contact_person" name="contact_person" class="form-control" 
                                       value="{{ old('contact_person') }}" required>
                            </div>
                            <div class="form-group">
                                <label for="contact_number" class="form-label">Contact Number *</label>
                                <input type="text" id="contact_number" name="contact_number" class="form-control" 
                                       value="{{ old('contact_number') }}" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Event Details</h3>
                        
                        <!-- Removed max participants option: events now auto-register all selected seniors -->

                        <div class="form-row">
                            <div class="form-group">
                                <label for="requirements" class="form-label">Requirements</label>
                                <textarea id="requirements" name="requirements" class="form-control" 
                                          rows="3">{{ old('requirements') }}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3 class="section-title">Target Recipients Selection</h3>
                        <p class="text-muted small mb-3">Choose who should receive notifications for this event</p>
                        <div class="d-flex flex-column gap-3">
                            <div class="card">
                                <div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_all" name="recipientTypes[]" value="all" class="form-check-input">
                                        <label for="recipients_all" class="form-check-label">All Senior Citizens</label>
                                    </div>
                                    <p class="text-muted small mb-0 ms-4">Send notification to every registered senior citizen</p>
                                </div>
                            </div>

                            <div class="card">
                                <div class="card-body">
                                    <div class="form-check">
                                        <input type="checkbox" id="recipients_barangay" name="recipientTypes[]" value="barangay" class="form-check-input">
                                        <label for="recipients_barangay" class="form-check-label">Filter by Barangay</label>
                                    </div>
                                    <p class="text-muted small mb-3 ms-4">Send notification to seniors in selected barangay(s)</p>
                                    <div id="barangaySelection" class="ms-4" style="display:none;">
                                        <h6 class="mb-3">Select Barangays</h6>
                                        <div class="row g-2">
                                            <div class="col-12 mb-2">
                                                <div class="form-check">
                                                    <input type="checkbox" id="barangay_all" name="selectedBarangays[]" value="all" class="form-check-input">
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
                                                        <input type="checkbox" id="barangay_{{ $barangay }}" name="selectedBarangays[]" value="{{ $barangay }}" class="form-check-input">
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
                                        <input type="checkbox" id="recipients_category" name="recipientTypes[]" value="category" class="form-check-input">
                                        <label for="recipients_category" class="form-check-label">Filter by Category</label>
                                    </div>
                                    <p class="text-muted small mb-3 ms-4">Auto-select seniors based on system records</p>
                                    <div id="categorySelection" class="ms-4" style="display:none;">
                                        <h6 class="mb-3">Select Categories</h6>
                                        <div class="d-flex flex-column gap-2">
                                            <div class="form-check">
                                                <input type="checkbox" id="category_pension" name="selectedCategories[]" value="pension" class="form-check-input">
                                                <label for="category_pension" class="form-check-label"><strong>Pension Recipients</strong><br><small class="text-muted">Seniors listed in the pension table</small></label>
                                            </div>
                                            <div class="form-check">
                                                <input type="checkbox" id="category_id" name="selectedCategories[]" value="id_applicants" class="form-check-input">
                                                <label for="category_id" class="form-check-label"><strong>ID Applicants</strong><br><small class="text-muted">Seniors from the ID application table</small></label>
                                            </div>
                                            <div class="form-check">
                                                <input type="checkbox" id="category_benefits" name="selectedCategories[]" value="benefit_applicants" class="form-check-input">
                                                <label for="category_benefits" class="form-check-label"><strong>Benefit Applicants</strong><br><small class="text-muted">Seniors from the benefits table</small></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="recipient_selection" name="recipient_selection" value="">
                    </div>

                    <div class="form-actions">
                        <a href="{{ route('events') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Create Event
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
                padding: 20px;
                background: #f8f9fa;
            }

            .form-container {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .form-header {
                background: #c01060;
                color: white;
                padding: 20px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .form-title {
                margin: 0;
                font-size: 24px;
                font-weight: 700;
            }

            .back-btn {
                color: white;
                text-decoration: none;
                padding: 8px 16px;
                border: 2px solid white;
                border-radius: 6px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .back-btn:hover {
                background: white;
                color: #e31575;
                text-decoration: none;
            }

            .event-form {
                padding: 30px;
            }

            .form-section {
                margin-bottom: 30px;
            }

            .section-title {
                color: #e31575;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #f0f0f0;
            }

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1;
            }

            .form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
            }

            .form-control {
                width: 100%;
                padding: 12px;
                border: 2px solid #ddd;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }

            .form-control:focus {
                outline: none;
                border-color: #e31575;
                box-shadow: 0 0 0 3px rgba(227, 21, 117, 0.1);
            }

            .form-text {
                font-size: 12px;
                color: #666;
                margin-top: 5px;
            }

            .form-actions {
                display: flex;
                gap: 15px;
                justify-content: flex-end;
                padding-top: 20px;
                border-top: 1px solid #eee;
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
                background: #5a6268;
                color: white;
                text-decoration: none;
            }

            .btn-primary {
                background: #e31575;
                color: white;
            }

            .btn-primary:hover {
                background: #c01060;
                color: white;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 6px;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            @media (max-width: 768px) {
                .main {
                    margin-left: 0;
                    padding: 10px;
                }
                
                .form-row {
                    flex-direction: column;
                    gap: 10px;
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
                const allBarangaysCheckbox = document.getElementById('barangay_all');
                const hiddenRecipientInput = document.getElementById('recipient_selection');

                function updateVisibility() {
                    barangaySelection.style.display = barangayCheckbox.checked ? 'block' : 'none';
                    categorySelection.style.display = categoryCheckbox.checked ? 'block' : 'none';
                }

                recipientCheckboxes.forEach(cb => {
                    cb.addEventListener('change', function() {
                        if (this.value === 'all' && this.checked) {
                            barangayCheckbox.checked = false;
                            categoryCheckbox.checked = false;
                        }
                        if ((this.value === 'barangay' || this.value === 'category') && this.checked) {
                            allSeniorsCheckbox.checked = false;
                        }
                        updateVisibility();
                    });
                });

                if (allBarangaysCheckbox) {
                    allBarangaysCheckbox.addEventListener('change', function() {
                        const barangayCheckboxes = document.querySelectorAll('input[name="selectedBarangays[]"]');
                        barangayCheckboxes.forEach(checkbox => { if (checkbox.value !== 'all') { checkbox.checked = this.checked; } });
                    });
                }

                const form = document.querySelector('form.event-form');
                form.addEventListener('submit', function(e) {
                    const types = [];
                    document.querySelectorAll('input[name="recipientTypes[]"]:checked').forEach(cb => types.push(cb.value));
                    const data = { types: types, barangays: [], categories: [] };
                    if (types.includes('barangay')) {
                        document.querySelectorAll('input[name="selectedBarangays[]"]:checked').forEach(cb => data.barangays.push(cb.value));
                    }
                    if (types.includes('category')) {
                        document.querySelectorAll('input[name="selectedCategories[]"]:checked').forEach(cb => data.categories.push(cb.value));
                    }
                    hiddenRecipientInput.value = JSON.stringify(data);
                });

                updateVisibility();
            });
        </script>
    </x-header>
</x-sidebar>
