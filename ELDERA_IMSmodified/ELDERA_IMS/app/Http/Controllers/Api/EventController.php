<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class EventController extends Controller
{
    /**
     * Display a listing of events.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $events = \App\Models\Event::with(['createdBy'])
            ->orderBy('event_date', 'desc')
            ->orderBy('start_time', 'desc')
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $events->items(),
            'pagination' => [
                'current_page' => $events->currentPage(),
                'last_page' => $events->lastPage(),
                'per_page' => $events->perPage(),
                'total' => $events->total(),
            ]
        ]);
    }

    /**
     * Display the specified event.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $event = \App\Models\Event::with(['createdBy', 'participants'])
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => [
                'id' => $event->id,
                'title' => $event->title,
                'description' => $event->description,
                'event_type' => $event->event_type,
                'event_type_text' => $event->event_type_text,
                'date' => $event->event_date->format('Y-m-d'),
                'time' => $event->start_time->format('H:i:s'),
                'end_time' => $event->end_time?->format('H:i:s'),
                'location' => $event->location,
                'organizer' => $event->organizer,
                'contact_person' => $event->contact_person,
                'contact_number' => $event->contact_number,
                'status' => $event->status,
                'status_text' => $event->status_text,
                'max_participants' => $event->max_participants,
                'current_participants' => $event->current_participants,
                'available_slots' => $event->available_slots,
                'is_full' => $event->is_full,
                'requirements' => $event->requirements,
                'created_by' => $event->createdBy?->name,
                'created_at' => $event->created_at->format('Y-m-d H:i:s'),
            ],
        ]);
    }

    /**
     * Get events for calendar display under API namespace.
     */
    public function calendar(Request $request)
    {
        $start = $request->get('start');
        $end = $request->get('end');

        $events = \App\Models\Event::whereBetween('event_date', [$start, $end])
            ->get()
            ->map(function ($event) {
                return [
                    'id' => $event->id,
                    'title' => $event->title,
                    'description' => $event->description,
                    'organizer' => $event->organizer,
                    'requirements' => $event->requirements,
                    'start' => $event->event_date->format('Y-m-d'),
                    'end' => $event->event_date->format('Y-m-d'),
                    'time' => $event->start_time->format('H:i'),
                    'end_time' => $event->end_time ? $event->end_time->format('H:i') : null,
                    'location' => $event->location,
                    'type' => $event->event_type,
                    'status' => $event->status,
                    'color' => $this->getEventColor($event->event_type ?? 'general'),
                    'created_at' => $event->created_at ? $event->created_at->toIso8601String() : null,
                ];
            });

        return response()->json([
            'success' => true,
            'data' => $events,
        ]);
    }

    /**
     * Get user attendance data for events.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getUserAttendance(Request $request)
    {
        $seniorId = $request->get('senior_id');
        
        if (!$seniorId) {
            return response()->json([
                'success' => false,
                'message' => 'Senior ID is required'
            ], 400);
        }

        // Get all event participations for the user
        $attendanceData = \App\Models\Event::with(['participants' => function($query) use ($seniorId) {
                $query->where('senior_id', $seniorId);
            }])
            ->whereHas('participants', function($query) use ($seniorId) {
                $query->where('senior_id', $seniorId);
            })
            ->orderBy('event_date', 'desc')
            ->get()
            ->map(function ($event) {
                $participant = $event->participants->first();
                return [
                    'event_id' => $event->id,
                    'event_title' => $event->title,
                    'event_date' => $event->event_date->format('Y-m-d'),
                    'event_time' => $event->start_time->format('H:i'),
                    'event_type' => $event->event_type,
                    'location' => $event->location,
                    'attended' => $participant ? $participant->pivot->attended : false,
                    'registered_at' => $participant ? $participant->pivot->registered_at : null,
                    'attendance_notes' => $participant ? $participant->pivot->attendance_notes : null,
                ];
            });

        // Calculate attendance statistics
        $totalEvents = $attendanceData->count();
        $attendedEvents = $attendanceData->where('attended', true)->count();
        $missedEvents = $totalEvents - $attendedEvents;

        return response()->json([
            'success' => true,
            'data' => [
                'attendance_records' => $attendanceData,
                'statistics' => [
                    'total' => $totalEvents,
                    'attended' => $attendedEvents,
                    'missed' => $missedEvents,
                    'attendance_rate' => $totalEvents > 0 ? round(($attendedEvents / $totalEvents) * 100, 1) : 0
                ]
            ]
        ]);
    }

    private function getEventColor(string $type): string
    {
        return match ($type) {
            'pension' => '#007bff',
            'health' => '#dc3545',
            'id_claiming' => '#17a2b8',
            default => '#6c757d',
        };
    }
}