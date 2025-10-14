import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/attendance.dart';
import '../utils/secure_logger.dart';
import 'secure_storage_service.dart';
import 'api_service.dart';

/// Attendance service for fetching user attendance records from IMS API
/// This service connects to the IMS system where admins can toggle attendance status
class AttendanceService {
  /// Get attendance records for a specific user from the event_participant table
  static Future<Map<String, dynamic>> getUserEventAttendance(
      String seniorId) async {
    try {
      final response =
          await ApiService.get('events/attendance/user?senior_id=$seniorId');

      if (response['success'] == true && response['data'] != null) {
        return response['data'];
      } else {
        throw Exception(
            'Failed to fetch attendance data: ${response['message']}');
      }
    } catch (e) {
      SecureLogger.error('Error fetching user event attendance: $e');
      return {
        'attendance_records': [],
        'statistics': {
          'total': 0,
          'attended': 0,
          'missed': 0,
          'attendance_rate': 0.0
        }
      };
    }
  }

  /// Convert attended field (int 1/0 or bool) to attendance status string
  static String _convertAttendedToStatus(dynamic attended) {
    if (attended == null) return 'missed';

    // Handle int values (1 = attended, 0 = missed)
    if (attended is int) {
      return attended == 1 ? 'attended' : 'missed';
    }

    // Handle bool values
    if (attended is bool) {
      return attended ? 'attended' : 'missed';
    }

    // Handle string values
    if (attended is String) {
      return attended.toLowerCase() == 'true' || attended == '1'
          ? 'attended'
          : 'missed';
    }

    return 'missed';
  }

  /// Legacy methods kept for backward compatibility
  /// Get attendance records for a specific user
  static Future<List<Attendance>> getUserAttendance(String userId) async {
    try {
      final attendanceData = await getUserEventAttendance(userId);
      final records =
          attendanceData['attendance_records'] as List<dynamic>? ?? [];

      return records
          .map<Attendance>((record) => Attendance(
                id: record['event_id']?.toString() ?? '',
                userId: userId,
                eventId: record['event_id']?.toString() ?? '',
                eventTitle: record['event_title'] ?? '',
                eventDate: record['event_date'] ?? '',
                attendanceStatus: _convertAttendedToStatus(record['attended']),
                notes: record['attendance_notes'],
              ))
          .toList();
    } catch (e) {
      SecureLogger.error('Error fetching user attendance: $e');
      return [];
    }
  }

  /// Get attendance records for a specific event
  static Future<List<Attendance>> getEventAttendance(String eventId) async {
    try {
      final response = await ApiService.get('events/$eventId/attendance');

      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> jsonData = response['data'];
        return jsonData.map((json) => Attendance.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to fetch event attendance: ${response['message']}');
      }
    } catch (e) {
      SecureLogger.error('Error fetching event attendance: $e');
      return [];
    }
  }

  /// Get attendance records for a user within a date range
  static Future<List<Attendance>> getUserAttendanceByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final startDateStr = startDate.toIso8601String().split('T')[0];
      final endDateStr = endDate.toIso8601String().split('T')[0];

      final response = await ApiService.get(
          'attendance/user/$userId/range?start_date=$startDateStr&end_date=$endDateStr');

      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> jsonData = response['data'];
        return jsonData.map((json) => Attendance.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to fetch attendance by date range: ${response['message']}');
      }
    } catch (e) {
      SecureLogger.error('Error fetching attendance by date range: $e');
      return [];
    }
  }

  /// Get attendance statistics for a user
  static Future<Map<String, int>> getUserAttendanceStats(String userId) async {
    try {
      final attendanceRecords = await getUserAttendance(userId);

      int attended = 0;
      int missed = 0;

      for (final record in attendanceRecords) {
        if (record.isAttended) {
          attended++;
        } else {
          missed++;
        }
      }

      return {
        'attended': attended,
        'missed': missed,
        'total': attended + missed,
      };
    } catch (e) {
      print('Error calculating attendance stats: $e');
      return {
        'attended': 0,
        'missed': 0,
        'total': 0,
      };
    }
  }

  /// Get authentication token from secure storage
  static Future<String?> _getAuthToken() async {
    try {
      return await SecureStorageService.getAuthToken();
    } catch (e) {
      print('Error getting auth token: $e');
      return null;
    }
  }

  /// Check if service is available
  static Future<bool> isServiceAvailable() async {
    try {
      final response = await ApiService.get('health');
      return response['success'] == true;
    } catch (e) {
      SecureLogger.error('Attendance service not available: $e');
      return false;
    }
  }
}