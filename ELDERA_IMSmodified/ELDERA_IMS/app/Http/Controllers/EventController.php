<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\Senior;
use App\Models\Application;
use App\Models\BenefitsApplication;
use App\Models\PensionApplication;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\View\View;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class EventController extends Controller
{
    /**
     * Display a listing of events.
     */
    public function index(): View
    {
        $events = Event::with(['createdBy'])
            ->orderBy('event_date', 'desc')
            ->orderBy('start_time', 'desc')
            ->get();

        return view('events', compact('events'));
    }

    /**
     * Show the form for creating a new event.
     */
    public function create(): View
    {
        return view('events.create');
    }

    /**
     * Store a newly created event in storage.
     */
    public function store(Request $request): JsonResponse|RedirectResponse
    {
        try {
            $validatedData = $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'event_type' => 'required|string|in:general,pension,health,id_claiming',
                'event_date' => 'required|date|after_or_equal:today',
                'start_time' => 'required|string',
                'end_time' => 'nullable|string',
                'location' => 'required|string|max:255',
                'organizer' => 'nullable|string|max:255',
                'contact_person' => 'nullable|string|max:255',
                'contact_number' => 'nullable|string|max:20',
                'requirements' => 'nullable|string',
                // Recipient selection (JSON from UI)
                'recipient_selection' => 'required|string',
            ]);

            try {
                $eventDate = \Carbon\Carbon::parse($validatedData['event_date']);
                $start = null; $end = null;
                if (!empty($validatedData['start_time'])) {
                    $start = \Carbon\Carbon::parse($eventDate->format('Y-m-d') . ' ' . $validatedData['start_time']);
                    $validatedData['start_time'] = $start->toTimeString();
                }
                if (!empty($validatedData['end_time'])) {
                    $end = \Carbon\Carbon::parse($eventDate->format('Y-m-d') . ' ' . $validatedData['end_time']);
                    $validatedData['end_time'] = $end->toTimeString();
                }
                if ($start && $end && $end->lte($start)) {
                    throw \Illuminate\Validation\ValidationException::withMessages([
                        'end_time' => 'End time must be after start time.'
                    ]);
                }
            } catch (\Illuminate\Validation\ValidationException $ve) {
                throw $ve;
            } catch (\Throwable $e) {
                \Log::warning('Event time normalization failed', ['error' => $e->getMessage()]);
            }

            $validatedData['status'] = 'upcoming';
            $validatedData['current_participants'] = 0;
            if (Auth::check()) {
                $validatedData['created_by'] = Auth::id();
            }

            // Normalize recipient_selection from request and save only if column exists
            $hasRecipientColumn = \Illuminate\Support\Facades\Schema::connection('eldera_ims')->hasColumn('events', 'recipient_selection');
            $recipientSelectionRaw = $validatedData['recipient_selection'] ?? null;
            $recipientSelection = null;
            if ($recipientSelectionRaw) {
                try {
                    $recipientSelection = json_decode($recipientSelectionRaw, true, 512, JSON_THROW_ON_ERROR);
                } catch (\Throwable $e) {
                    \Log::warning('Invalid recipient_selection JSON on event store', ['error' => $e->getMessage()]);
                }
            }
            // Validate selection: at least one type, and details for barangay/category when chosen
            if (!is_array($recipientSelection) || empty($recipientSelection['types'])) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'recipient_selection' => 'Please select at least one recipient type.'
                ]);
            }
            if (in_array('barangay', $recipientSelection['types'] ?? []) && empty($recipientSelection['barangays'])) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'recipient_selection' => 'Please select at least one barangay.'
                ]);
            }
            if (in_array('category', $recipientSelection['types'] ?? []) && empty($recipientSelection['categories'])) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'recipient_selection' => 'Please select at least one category.'
                ]);
            }
            if ($hasRecipientColumn) {
                $validatedData['recipient_selection'] = is_array($recipientSelection) ? $recipientSelection : null;
            } else {
                unset($validatedData['recipient_selection']);
            }

            $event = Event::create($validatedData);

            // Auto-register participants based on recipient selection from UI
            // Use already-normalized $recipientSelection above

            if (is_array($recipientSelection)) {
                $seniorIds = $this->resolveRecipientSeniorIds($recipientSelection);

                if (!empty($seniorIds)) {
                    $attachData = [];
                    $now = now();
                    foreach ($seniorIds as $sid) {
                        $attachData[$sid] = [
                            'registered_at' => $now,
                            'attended' => false,
                            'created_at' => $now,
                            'updated_at' => $now,
                        ];
                    }
                    // Avoid duplicates if any
                    $event->participants()->syncWithoutDetaching($attachData);
                    $event->update(['current_participants' => $event->participants()->count()]);
                }
            }
            // If request is AJAX/JSON, return payload with event id for client redirect
            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => true,
                    'event_id' => $event->id,
                ]);
            }

            // Redirect to Manage Participants to monitor attendance
            return redirect()->route('events.participants', $event->id)
                ->with('success', 'Event created successfully and participants auto-registered.');

        } catch (\Illuminate\Validation\ValidationException $e) {
            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'errors' => $e->errors(),
                ], 422);
            }
            return redirect()->back()
                ->withErrors($e->errors())
                ->withInput();
        } catch (\Exception $e) {
            Log::error('Error creating event: ' . $e->getMessage());
            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'An error occurred while creating the event. Please try again.'
                ], 500);
            }
            return redirect()->back()
                ->with('error', 'An error occurred while creating the event. Please try again.');
        }
    }

    /**
     * Display the specified event.
     */
    public function show(string $id): View
    {
        $event = Event::with(['createdBy', 'participants'])
            ->findOrFail($id);

        return view('events.show', compact('event'));
    }

    /**
     * Show the form for editing the specified event.
     */
    public function edit(string $id): View
    {
        $event = Event::findOrFail($id);

        return view('events.edit', compact('event'));
    }

    /**
     * Update the specified event in storage.
     */
    public function update(Request $request, string $id): JsonResponse|RedirectResponse
    {
        try {
            $event = Event::findOrFail($id);

            // Allow lightweight status-only updates for AJAX requests
            $isStatusOnlyUpdate = ($request->ajax() || $request->expectsJson())
                && $request->has('status')
                && !$request->has('title')
                && !$request->has('event_type')
                && !$request->has('event_date')
                && !$request->has('start_time')
                && !$request->has('location');

            if ($isStatusOnlyUpdate) {
                $statusData = $request->validate([
                    'status' => 'required|string|in:upcoming,ongoing,completed,cancelled',
                ]);

                $event->update(['status' => $statusData['status']]);

                if ($request->ajax() || $request->expectsJson()) {
                    return response()->json([
                        'success' => true,
                        'event_id' => $event->id,
                    ]);
                }

                return redirect()->route('events')
                    ->with('success', 'Event status updated successfully!');
            }

            \Log::info('Event update request received', ['id' => $id, 'raw' => $request->all()]);
            $validatedData = $request->validate([
                'title' => 'sometimes|required|string|max:255',
                'description' => 'nullable|string',
                'event_type' => 'sometimes|required|string|in:general,pension,health,id_claiming',
                'event_date' => 'sometimes|required|date',
                'start_time' => 'sometimes|required|string',
                'end_time' => 'nullable|string',
                'location' => 'sometimes|required|string|max:255',
                'organizer' => 'nullable|string|max:255',
                'contact_person' => 'nullable|string|max:255',
                'contact_number' => 'nullable|string|max:20',
                'requirements' => 'nullable|string',
                'status' => 'sometimes|required|string|in:upcoming,ongoing,completed,cancelled',
                // recipient_selection handled conditionally below to avoid overwriting when absent
            ]);
            \Log::info('Event update validated data', ['id' => $id, 'data' => $validatedData]);

            try {
                $eventDate = isset($validatedData['event_date']) ? \Carbon\Carbon::parse($validatedData['event_date']) : ($event->event_date ?? \Carbon\Carbon::now());
                $start = null; $end = null;
                if (array_key_exists('start_time', $validatedData) && !empty($validatedData['start_time'])) {
                    $start = \Carbon\Carbon::parse($eventDate->format('Y-m-d') . ' ' . $validatedData['start_time']);
                    $validatedData['start_time'] = $start->toTimeString();
                }
                if (array_key_exists('end_time', $validatedData) && !empty($validatedData['end_time'])) {
                    $end = \Carbon\Carbon::parse($eventDate->format('Y-m-d') . ' ' . $validatedData['end_time']);
                    $validatedData['end_time'] = $end->toTimeString();
                }
                if ($start && $end && $end->lte($start)) {
                    throw \Illuminate\Validation\ValidationException::withMessages([
                        'end_time' => 'End time must be after start time.'
                    ]);
                }
            } catch (\Illuminate\Validation\ValidationException $ve) {
                throw $ve;
            } catch (\Throwable $e) {
                \Log::warning('Event time normalization failed on update', ['error' => $e->getMessage()]);
            }

            // Normalize recipient_selection only if provided; otherwise keep existing value
            $hasRecipientColumn = \Illuminate\Support\Facades\Schema::connection('eldera_ims')->hasColumn('events', 'recipient_selection');
            $recipientSelection = null;
            $shouldProcessRecipient = $request->has('recipient_selection');
            if ($shouldProcessRecipient) {
                $recipientSelectionRaw = $request->input('recipient_selection');
                if ($recipientSelectionRaw !== null && $recipientSelectionRaw !== '') {
                    try {
                        $recipientSelection = json_decode($recipientSelectionRaw, true, 512, JSON_THROW_ON_ERROR);
                    } catch (\Throwable $e) {
                        \Log::warning('Invalid recipient_selection JSON on event update', ['error' => $e->getMessage()]);
                    }
                }
                // Validate recipient selection when provided
                if (!is_array($recipientSelection) || empty($recipientSelection['types'])) {
                    throw \Illuminate\Validation\ValidationException::withMessages([
                        'recipient_selection' => 'Please select at least one recipient type.'
                    ]);
                }
                if (in_array('barangay', $recipientSelection['types'] ?? []) && empty($recipientSelection['barangays'])) {
                    throw \Illuminate\Validation\ValidationException::withMessages([
                        'recipient_selection' => 'Please select at least one barangay.'
                    ]);
                }
                if (in_array('category', $recipientSelection['types'] ?? []) && empty($recipientSelection['categories'])) {
                    throw \Illuminate\Validation\ValidationException::withMessages([
                        'recipient_selection' => 'Please select at least one category.'
                    ]);
                }
                if ($hasRecipientColumn) {
                    // Only set when provided; if invalid JSON, set to null explicitly
                    $validatedData['recipient_selection'] = is_array($recipientSelection) ? $recipientSelection : null;
                } else {
                    unset($validatedData['recipient_selection']);
                }
            } else {
                // Prevent accidental overwrite when field is absent
                unset($validatedData['recipient_selection']);
            }

            // If end_time was provided empty, normalize to null to satisfy TIME column
            if (array_key_exists('end_time', $validatedData) && ($validatedData['end_time'] === '' || $validatedData['end_time'] === null)) {
                $validatedData['end_time'] = null;
            }

            $before = $event->only(['title','description','event_type','event_date','start_time','end_time','location','organizer','contact_person','contact_number','status','requirements']);
            $event->update($validatedData);
            $event->refresh();
            $after = $event->only(['title','description','event_type','event_date','start_time','end_time','location','organizer','contact_person','contact_number','status','requirements']);
            \Log::info('Event updated', ['id' => $event->id, 'before' => $before, 'after' => $after, 'changed' => $event->wasChanged()]);
            try {
                $hasParticipantsTable = \Illuminate\Support\Facades\Schema::connection('eldera_ims')->hasTable('event_participants');
                if ($hasParticipantsTable && is_array($recipientSelection)) {
                    $seniorIds = $this->resolveRecipientSeniorIds($recipientSelection);
                    if (!empty($seniorIds)) {
                        $attachData = [];
                        $now = now();
                        $existingPivot = $event->participants()
                            ->whereIn('seniors.id', $seniorIds)
                            ->get()
                            ->mapWithKeys(function ($participant) {
                                return [$participant->id => (bool)$participant->pivot->attended];
                            });
                        foreach ($seniorIds as $sid) {
                            $attachData[$sid] = [
                                'registered_at' => $now,
                                'attended' => (bool)($existingPivot[$sid] ?? false),
                                'created_at' => $now,
                                'updated_at' => $now,
                            ];
                        }
                        $event->participants()->sync($attachData);
                        $event->update(['current_participants' => $event->participants()->count()]);
                    }
                } elseif (!$hasParticipantsTable) {
                    \Log::warning('event_participants table missing on eldera_ims; skipping participant sync on update');
                }
            } catch (\Throwable $e) {
                \Log::warning('Participant sync failed on event update', ['error' => $e->getMessage()]);
            }

            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => true,
                    'event_id' => $event->id,
                    'event' => $after,
                    'changed' => $event->wasChanged(),
                ]);
            }

            return redirect()->route('events')
                ->with('success', 'Event updated successfully!');

        } catch (\Illuminate\Validation\ValidationException $e) {
            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'errors' => $e->errors(),
                ], 422);
            }
            return redirect()->back()->withErrors($e->errors())->withInput();
        } catch (\Exception $e) {
            Log::error('Error updating event: ' . $e->getMessage());
            if ($request->ajax() || $request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'An error occurred while updating the event. Please try again.'
                ], 500);
            }
            return redirect()->back()->with('error', 'An error occurred while updating the event. Please try again.');
        }
    }

    /**
     * Remove the specified event from storage.
     */
    public function destroy(string $id): RedirectResponse
    {
        try {
            $event = Event::findOrFail($id);
            $event->delete();

            return redirect()->route('events')
                ->with('success', 'Event deleted successfully!');

        } catch (\Exception $e) {
            Log::error('Error deleting event: ' . $e->getMessage());
            return redirect()->back()
                ->with('error', 'An error occurred while deleting the event. Please try again.');
        }
    }

    /**
     * Show participants for an event.
     */
    public function participants(Request $request, string $id): View
    {
        $event = Event::with(['participants', 'createdBy'])->findOrFail($id);

        // Auto-sync participants for pension events to match Social Pension table
        try {
            $hasRecipientColumn = \Illuminate\Support\Facades\Schema::connection('eldera_ims')->hasColumn('events', 'recipient_selection');
            $selection = null;
            if ($hasRecipientColumn) {
                $selection = is_array($event->recipient_selection)
                    ? $event->recipient_selection
                    : (function ($raw) {
                        if (!$raw) return null;
                        try { return json_decode($raw, true, 512, JSON_THROW_ON_ERROR); } catch (\Throwable $e) { return null; }
                    })($event->recipient_selection);
            }
            $shouldSyncPension = ($event->event_type === 'pension')
                || (is_array($selection) && in_array('category', ($selection['types'] ?? []), true) && in_array('pension', ($selection['categories'] ?? []), true));

            if ($shouldSyncPension) {
                $pensionSeniorIds = Application::where('application_type', 'pension')
                    ->whereHas('senior')
                    ->pluck('senior_id')
                    ->filter()
                    ->unique()
                    ->values()
                    ->all();

                if (!empty($pensionSeniorIds)) {
                    $existingIds = $event->participants()->pluck('seniors.id')->all();
                    $missingIds = array_values(array_diff($pensionSeniorIds, $existingIds));
                    if (!empty($missingIds)) {
                        $now = now();
                        $attachData = [];
                        foreach ($missingIds as $sid) {
                            $attachData[$sid] = [
                                'registered_at' => $now,
                                'attended' => false,
                                'created_at' => $now,
                                'updated_at' => $now,
                            ];
                        }
                        $event->participants()->syncWithoutDetaching($attachData);
                        $event->update(['current_participants' => $event->participants()->count()]);
                        // Refresh relationship for the view
                        $event->load('participants');
                    }
                }
            }
        } catch (\Throwable $e) {
            Log::warning('Participants auto-sync skipped: '.$e->getMessage());
        }

        // Server-side search filter for participants
        $search = trim((string)$request->get('search', ''));
        if ($search !== '') {
            $participants = $event->participants()
                ->select('seniors.*')
                ->where(function($q) use ($search) {
                    $q->where('first_name', 'like', "%{$search}%")
                      ->orWhere('last_name', 'like', "%{$search}%")
                      ->orWhereRaw("CONCAT(first_name, ' ', last_name) LIKE ?", ["%{$search}%"])
                      ->orWhere('osca_id', 'like', "%{$search}%");
                })
                ->get();
            $event->setRelation('participants', $participants);
        }

        // Get all seniors for potential registration
        $allSeniors = Senior::select('id', 'first_name', 'last_name', 'osca_id')->get();
        
        return view('events.participants', compact('event', 'allSeniors'));
    }

    /**
     * Update participant attendance.
     */
    public function updateAttendance(Request $request, string $eventId, string $seniorId): JsonResponse
    {
        try {
            $event = Event::findOrFail($eventId);
            $senior = Senior::findOrFail($seniorId);
            
            $attended = $request->boolean('attended');
            
            // Update the attendance in the pivot table
            $event->participants()->updateExistingPivot($seniorId, [
                'attended' => $attended,
                'updated_at' => now()
            ]);
            
            return response()->json([
                'success' => true,
                'message' => 'Attendance updated successfully',
                'attended' => $attended
            ]);
            
        } catch (\Exception $e) {
            Log::error('Error updating attendance: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while updating attendance'
            ], 500);
        }
    }

    /**
     * Register a senior for an event.
     */
    public function registerParticipant(Request $request, string $eventId): RedirectResponse
    {
        try {
            $event = Event::findOrFail($eventId);
            $seniorId = $request->input('senior_id');
            
            if (!$seniorId) {
                return redirect()->back()->with('error', 'Please select a senior to register.');
            }
            
            $senior = Senior::findOrFail($seniorId);
            
            // Check if already registered
            if ($event->participants()->where('senior_id', $seniorId)->exists()) {
                return redirect()->back()->with('error', 'This senior is already registered for this event.');
            }
            
            // Register the senior
            $event->participants()->attach($seniorId, [
                'registered_at' => now(),
                'attended' => false,
                'created_at' => now(),
                'updated_at' => now()
            ]);
            
            // Update current participants count
            $event->increment('current_participants');
            
            return redirect()->back()->with('success', 'Senior registered successfully for the event.');
            
        } catch (\Exception $e) {
            Log::error('Error registering participant: ' . $e->getMessage());
            return redirect()->back()->with('error', 'An error occurred while registering the participant.');
        }
    }

    /**
     * Remove a participant from an event.
     */
    public function removeParticipant(string $eventId, string $seniorId): RedirectResponse
    {
        try {
            $event = Event::findOrFail($eventId);
            
            $detached = $event->participants()->detach($seniorId);
            
            if ($detached) {
                $event->decrement('current_participants');
                return redirect()->back()->with('success', 'Participant removed successfully.');
            }
            
            return redirect()->back()->with('error', 'Participant not found.');
            
        } catch (\Exception $e) {
            Log::error('Error removing participant: ' . $e->getMessage());
            return redirect()->back()->with('error', 'An error occurred while removing the participant.');
        }
    }

    /**
     * Get events for calendar display.
     */
    public function getCalendarEvents(Request $request)
    {
        $start = $request->get('start');
        $end = $request->get('end');

        $events = Event::whereBetween('event_date', [$start, $end])
            ->get()
            ->map(function ($event) {
                return [
                    'id' => $event->id,
                    'title' => $event->title,
                    // Provide full IMS context for mobile app cards
                    'description' => $event->description,
                    'requirements' => $event->requirements,
                    'start' => $event->event_date->format('Y-m-d'),
                    'end' => $event->event_date->format('Y-m-d'),
                    'time' => (function($t){
                        if ($t instanceof \Carbon\CarbonInterface) return $t->format('H:i');
                        if (is_string($t) && $t !== '') { try { return \Carbon\Carbon::createFromFormat('H:i:s', $t)->format('H:i'); } catch(\Throwable $e) { return null; } }
                        return null;
                    })($event->start_time),
                    // Include end_time for mobile app to show time range
                    'end_time' => (function($t){
                        if ($t instanceof \Carbon\CarbonInterface) return $t->format('H:i');
                        if (is_string($t) && $t !== '') { try { return \Carbon\Carbon::createFromFormat('H:i:s', $t)->format('H:i'); } catch(\Throwable $e) { return null; } }
                        return null;
                    })($event->end_time),
                    'location' => $event->location,
                    'type' => $event->event_type,
                    'status' => $event->status,
                    'color' => $this->getEventColor($event->event_type),
                    // Include created_at for mobile app to use as posted date
                    'created_at' => $event->created_at ? $event->created_at->toIso8601String() : null,
                ];
            });

        return response()->json($events);
    }

    /**
     * Get event color based on type.
     */
    private function getEventColor(string $type): string
    {
        return match($type) {
            'general' => '#007bff',
            'pension' => '#28a745',
            'health' => '#dc3545',
            'id_claiming' => '#ffc107',
            default => '#6c757d'
        };
    }

    /**
     * Resolve senior IDs to auto-register from recipient selection payload.
     *
     * Expected structure:
     * [
     *   'types' => ['all'|'barangay'|'category', ...],
     *   'barangays' => ['all'|'<name>', ...],
     *   'categories' => ['pension'|'id_applicants'|'benefit_applicants', ...]
     * ]
     */
    private function resolveRecipientSeniorIds(array $selection): array
    {
        $ids = collect();

        $types = collect($selection['types'] ?? []);

        // All seniors
        if ($types->contains('all')) {
            $ids = $ids->merge(
                Senior::pluck('id')
            );
        }

        // Barangay-based selection
        if ($types->contains('barangay')) {
            $barangays = collect($selection['barangays'] ?? []);
            if ($barangays->contains('all')) {
                $ids = $ids->merge(
                    Senior::pluck('id')
                );
            } else if ($barangays->isNotEmpty()) {
                $selected = array_map('strtolower', $barangays->all());
                $ids = $ids->merge(
                    Senior::whereIn(\Illuminate\Support\Facades\DB::raw('LOWER(barangay)'), $selected)->pluck('id')
                );
            }
        }

        // Category-based selection
        if ($types->contains('category')) {
            $categories = collect($selection['categories'] ?? []);

            if ($categories->contains('pension')) {
                // Match the Social Pension table source: seniors with a pension application record
                $pensionSeniorIds = Application::where('application_type', 'pension')
                    ->whereHas('senior')
                    ->pluck('senior_id');
                $ids = $ids->merge($pensionSeniorIds);
            }
            if ($categories->contains('benefit_applicants')) {
                $benefitSeniorIds = BenefitsApplication::whereNotNull('senior_id')->pluck('senior_id');
                $ids = $ids->merge($benefitSeniorIds);
            }
            if ($categories->contains('id_applicants')) {
                $idSeniorIds = Application::where('application_type', 'senior_id')->pluck('senior_id');
                $ids = $ids->merge($idSeniorIds);
            }
        }

        // Ensure IDs are valid seniors (include all statuses)
        $uniqueIds = $ids->filter()->unique()->values();
        if ($uniqueIds->isEmpty()) {
            return [];
        }

        return Senior::whereIn('id', $uniqueIds->all())->pluck('id')->all();
    }
}
