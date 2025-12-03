import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/announcement.dart';
import 'local_notification_service.dart';
import 'language_service.dart';
import 'calendar_integration_service.dart';
import 'service_manager.dart';

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  // Singleton instance getter
  static ReminderService get instance => _instance;

  // Store reminders in memory and persist to SharedPreferences
  final Map<String, Announcement> _reminders = {};
  static const String _remindersKey = 'scheduled_reminders';
  static const String _reminderTimesKey = 'reminder_times';
  bool _isInitialized = false;

  // Add a reminder for an announcement
  Future<bool> setReminder(Announcement announcement, String reminderType,
      {DateTime? customTime, bool addToCalendar = false}) async {
    // Setting reminder for announcement

    try {
      DateTime? reminderTime;
      DateTime eventTime = parseEventDateTime(announcement.when);
      // Parsed event time

      switch (reminderType) {
        case '1_hour_before':
          reminderTime = eventTime.subtract(const Duration(hours: 1));
          break;
        case '1_day_before':
          reminderTime = eventTime.subtract(const Duration(days: 1));
          break;
        case 'custom':
          reminderTime = customTime;
          break;
        default:
          // Invalid reminder type
          return false;
      }

      // Calculated reminder time

      if (reminderTime == null) {
        // Reminder time calculation failed
        return false;
      }

      if (reminderTime.isBefore(DateTime.now())) {
        // Cannot set reminder in the past
        return false;
      }

      if (reminderTime.isAfter(eventTime)) {
        // Cannot set reminder after the event
        return false;
      }

      // Create updated announcement with reminder info
      final updatedAnnouncement = Announcement(
        id: announcement.id,
        title: announcement.title,
        postedDate: announcement.postedDate,
        what: announcement.what,
        when: announcement.when,
        where: announcement.where,
        category: announcement.category,
        department: announcement.department,
        iconType: announcement.iconType,
        hasReminder: announcement.hasReminder,
        hasListen: announcement.hasListen,
        backgroundColor: announcement.backgroundColor,
        isReminderSet: true,
        reminderTime: reminderTime,
        reminderType: reminderType,
      );

      _reminders[announcement.id] = updatedAnnouncement;
      // Reminder stored in memory

      // Persist reminder to SharedPreferences
      await _saveRemindersToStorage();

      // Schedule the local notification
      debugPrint(
          '📅 Scheduling notification for ${announcement.title} at ${reminderTime.toString()}');
      try {
        final serviceManager = ServiceManager();
        final notificationService = serviceManager.notificationService;
        if (notificationService != null) {
          final enabled = await notificationService.areNotificationsEnabled();
          if (!enabled) {
            await notificationService.requestPermissions();
          }
          final canExact = await notificationService.canScheduleExactAlarms();
          if (!canExact) {
            await notificationService.requestExactAlarmPermissionWithGuidance();
          }
        }
      } catch (_) {}
      await _scheduleNotification(updatedAnnouncement);

      // Test immediate notification to verify system is working
      await _testImmediateNotification(announcement);

      // Add to device calendar if requested
      if (addToCalendar) {
        // Adding event to calendar
        final calendarService = CalendarIntegrationService();
        final calendarSuccess = await calendarService
            .addAnnouncementToCalendar(updatedAnnouncement);
        if (calendarSuccess) {
          // Event added to calendar
        } else {
          // Failed to add event to calendar
        }
      }

      // Reminder set successfully
      return true;
    } catch (e) {
      debugPrint('Error setting reminder: $e');
      return false;
    }
  }

  // Remove a reminder
  Future<bool> removeReminder(String announcementId,
      {bool removeFromCalendar = false}) async {
    try {
      if (_reminders.containsKey(announcementId)) {
        final announcement = _reminders[announcementId]!;
        _reminders.remove(announcementId);

        // Persist changes to SharedPreferences
        await _saveRemindersToStorage();

        // Cancel the scheduled notification
        await _cancelNotification(announcementId);

        // Remove from device calendar if requested
        if (removeFromCalendar) {
          // Removing event from calendar
          final calendarService = CalendarIntegrationService();
          final calendarSuccess = await calendarService
              .removeAnnouncementFromCalendar(announcement.id);
          if (calendarSuccess) {
            // Event removed from calendar
          } else {
            // Failed to remove event from calendar
          }
        }

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error removing reminder: $e');
      return false;
    }
  }

  // Get reminder for an announcement
  Announcement? getReminder(String announcementId) {
    return _reminders[announcementId];
  }

  // Check if announcement has reminder set
  bool hasReminder(String announcementId) {
    return _reminders.containsKey(announcementId) &&
        _reminders[announcementId]!.isReminderSet;
  }

  // Get all reminders
  List<Announcement> getAllReminders() {
    return _reminders.values.toList();
  }

  // Get upcoming reminders (next 24 hours)
  List<Announcement> getUpcomingReminders() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    return _reminders.values.where((reminder) {
      return reminder.reminderTime != null &&
          reminder.reminderTime!.isAfter(now) &&
          reminder.reminderTime!.isBefore(tomorrow);
    }).toList();
  }

  // Parse event date time from string
  DateTime parseEventDateTime(String whenString) {
    try {
      // Supports:
      //  - "August 26, 2025 at 9:00 AM"
      //  - "September 4, 2025 - 3:00 PM to 6:00 PM" (uses start time)
      //  - "October 19, 2025 - 9:00 AM" (uses provided time)
      //  - "October 19, 2025" (defaults to 9:00 AM)

      whenString = whenString.trim();

      String datePart;
      String? timePart;

      if (whenString.contains(' at ')) {
        final parts = whenString.split(' at ');
        if (parts.length != 2) {
          throw FormatException('Invalid date format');
        }
        datePart = parts[0].trim();
        timePart = parts[1].trim();
      } else if (whenString.contains(' - ')) {
        final parts = whenString.split(' - ');
        if (parts.isEmpty) {
          throw FormatException('Invalid date format');
        }
        datePart = parts[0].trim();
        if (parts.length > 1) {
          timePart = parts[1].trim();
          if (timePart.contains(' to ')) {
            timePart = timePart.split(' to ').first.trim();
          }
        }
      } else {
        // Date only, default time to 9:00 AM
        datePart = whenString;
        timePart = null;
      }

      // Parse date part (e.g., "August 26, 2025")
      final dateComponents = datePart.split(' ');
      if (dateComponents.length != 3) {
        throw FormatException('Invalid date format');
      }

      final month = _getMonthNumber(dateComponents[0]);
      final day = int.parse(dateComponents[1].replaceAll(',', ''));
      final year = int.parse(dateComponents[2]);

      int hour = 9;
      int minute = 0;

      if (timePart != null && timePart.isNotEmpty) {
        // Parse time part (e.g., "9:00 AM")
        final timeComponents = timePart.split(' ');
        if (timeComponents.length != 2) {
          // If time format unexpected, default to 9:00 AM
          return DateTime(year, month, day, hour, minute);
        }

        final time = timeComponents[0];
        final ampm = timeComponents[1].toUpperCase();

        final timeNumbers = time.split(':');
        if (timeNumbers.isEmpty) {
          return DateTime(year, month, day, hour, minute);
        }
        hour = int.tryParse(timeNumbers[0]) ?? hour;
        minute =
            timeNumbers.length > 1 ? int.tryParse(timeNumbers[1]) ?? minute : 0;

        if (ampm == 'PM' && hour != 12) {
          hour += 12;
        } else if (ampm == 'AM' && hour == 12) {
          hour = 0;
        }
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      // Error parsing date
      // Return a safe future timestamp if parsing fails
      return DateTime.now().add(const Duration(hours: 1));
    }
  }

  // Parse event start/end time range from the formatted "when" string
  // Returns DateTimeRange where end equals start if no end time provided
  DateTimeRange parseEventTimeRange(String whenString) {
    try {
      String input = whenString.trim();

      String datePart;
      String? startTimePart;
      String? endTimePart;

      if (input.contains(' at ')) {
        // "December 25, 2024 at 2:00 PM"
        final parts = input.split(' at ');
        if (parts.length != 2) throw FormatException('Invalid date format');
        datePart = parts[0].trim();
        startTimePart = parts[1].trim();
      } else if (input.contains(' - ')) {
        // "December 25, 2024 - 2:00 PM to 5:00 PM" or "December 25, 2024 - 2:00 PM"
        final parts = input.split(' - ');
        if (parts.isEmpty) throw FormatException('Invalid date format');
        datePart = parts[0].trim();
        if (parts.length > 1) {
          String timeSegment = parts[1].trim();
          if (timeSegment.contains(' to ')) {
            final tparts = timeSegment.split(' to ');
            startTimePart = tparts.first.trim();
            endTimePart = tparts.length > 1 ? tparts[1].trim() : null;
          } else {
            startTimePart = timeSegment;
          }
        }
      } else {
        // Date only, default times to 9:00 AM – 9:00 AM
        datePart = input;
        startTimePart = null;
      }

      // Parse date part (e.g., "August 26, 2025")
      final dateComponents = datePart.split(' ');
      if (dateComponents.length != 3)
        throw FormatException('Invalid date format');
      final month = _getMonthNumber(dateComponents[0]);
      final day = int.parse(dateComponents[1].replaceAll(',', ''));
      final year = int.parse(dateComponents[2]);

      // Defaults
      int sh = 9;
      int sm = 0;
      int eh = 9;
      int em = 0;

      if (startTimePart != null && startTimePart.isNotEmpty) {
        final timeVals = _parseClockTime(startTimePart);
        sh = timeVals[0];
        sm = timeVals[1];
      }

      DateTime start = DateTime(year, month, day, sh, sm);

      if (endTimePart != null && endTimePart.isNotEmpty) {
        final eVals = _parseClockTime(endTimePart);
        eh = eVals[0];
        em = eVals[1];
      } else {
        // No end provided -> end equals start
        eh = sh;
        em = sm;
      }

      DateTime end = DateTime(year, month, day, eh, em);
      return DateTimeRange(start: start, end: end);
    } catch (_) {
      final now = DateTime.now();
      return DateTimeRange(
          start: now.add(const Duration(hours: 1)),
          end: now.add(const Duration(hours: 1)));
    }
  }

  // Helper: parse times like "9:00 AM" or "14:30" into 24h clock
  // Returns [hour, minute]
  List<int> _parseClockTime(String timePart) {
    String t = timePart.trim();
    String? ampm;
    if (t.contains(' ')) {
      final comps = t.split(' ');
      t = comps[0].trim();
      ampm = comps.length > 1 ? comps[1].trim().toUpperCase() : null;
    }

    int hour = 9;
    int minute = 0;
    final m = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(t);
    if (m != null) {
      hour = int.tryParse(m.group(1)!) ?? 9;
      minute = int.tryParse(m.group(2)!) ?? 0;
    } else {
      // Fallback single-hour like "9" -> 09:00
      final hOnly = int.tryParse(t);
      if (hOnly != null) {
        hour = hOnly;
        minute = 0;
      }
    }

    if (ampm == 'PM' && hour != 12) {
      hour += 12;
    } else if (ampm == 'AM' && hour == 12) {
      hour = 0;
    }

    return [hour, minute];
  }

  // Helper method to get month number from name
  int _getMonthNumber(String monthName) {
    const months = {
      'January': 1, 'February': 2, 'March': 3, 'April': 4,
      'May': 5, 'June': 6, 'July': 7, 'August': 8,
      'September': 9, 'October': 10, 'November': 11, 'December': 12,
      // Short forms
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,
      'Jun': 6, 'Jul': 7, 'Aug': 8,
      'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12,
    };
    return months[monthName] ??
        months[monthName.substring(0, 1).toUpperCase() +
            monthName.substring(1).toLowerCase()] ??
        1;
  }

  // Test immediate notification to verify system is working
  Future<void> _testImmediateNotification(Announcement announcement) async {
    final serviceManager = ServiceManager();
    final notificationService = serviceManager.notificationService;
    if (notificationService == null) {
      debugPrint('⚠️ Cannot test notification - service not available');
      return;
    }

    try {
      final success = await notificationService.showImmediateNotification(
        title: 'Reminder Set ✅',
        body:
            'Your reminder for "${announcement.title}" has been set successfully!',
        payload: announcement.id,
      );

      if (success) {
        debugPrint('✅ Test notification sent successfully');
      } else {
        debugPrint('❌ Test notification failed');
      }
    } catch (e) {
      debugPrint('❌ Error sending test notification: $e');
    }
  }

  /// Test notification system with immediate notification
  Future<bool> testImmediateNotification() async {
    final serviceManager = ServiceManager();
    final notificationService = serviceManager.notificationService;

    if (notificationService == null) {
      debugPrint('⚠️ Notification service not available');
      return false;
    }

    try {
      debugPrint('🧪 Testing immediate notification...');
      final success = await notificationService.showImmediateNotification(
        title: 'Test Notification 🧪',
        body:
            'This is a test to verify the notification system is working correctly.',
        payload: 'test_notification',
      );

      if (success) {
        debugPrint('✅ Immediate notification test successful');
      } else {
        debugPrint('❌ Immediate notification test failed');
      }

      return success;
    } catch (e) {
      debugPrint('❌ Error testing immediate notification: $e');
      return false;
    }
  }

  /// Test notification system with short delay (1 minute)
  Future<bool> testShortDelayNotification() async {
    final serviceManager = ServiceManager();
    final notificationService = serviceManager.notificationService;

    if (notificationService == null) {
      debugPrint('⚠️ Notification service not available');
      return false;
    }

    try {
      final testTime = DateTime.now().add(const Duration(minutes: 1));
      debugPrint('🧪 Testing short delay notification for: $testTime');

      final success = await notificationService.scheduleReminderNotification(
        announcementId:
            'test_short_delay_${DateTime.now().millisecondsSinceEpoch}',
        title: 'Short Delay Test 🧪',
        body:
            'This notification was scheduled 1 minute ago to test the scheduling system.',
        scheduledTime: testTime,
      );

      if (success) {
        debugPrint('✅ Short delay notification scheduled successfully');
        debugPrint('   ⏰ Should appear at: $testTime');
      } else {
        debugPrint('❌ Short delay notification scheduling failed');
      }

      return success;
    } catch (e) {
      debugPrint('❌ Error testing short delay notification: $e');
      return false;
    }
  }

  // Schedule notification using LocalNotificationService
  Future<void> _scheduleNotification(Announcement announcement) async {
    if (announcement.reminderTime == null) return;

    final serviceManager = ServiceManager();
    final notificationService = serviceManager.notificationService;
    if (notificationService == null) {
      debugPrint(
          '⚠️ Notification service not available - waiting for initialization');
      // Wait for service to be ready
      await serviceManager.waitForService('notification');
      final retryService = serviceManager.notificationService;
      if (retryService == null) {
        debugPrint('❌ Failed to get notification service after waiting');
        return;
      }

      final success = await retryService.scheduleReminderNotification(
        announcementId: announcement.id,
        title: 'Event Reminder: ${announcement.title}',
        body: LocalNotificationService.createNotificationBody(
            announcement, announcement.reminderType ?? 'custom'),
        scheduledTime: announcement.reminderTime!,
      );

      if (success) {
        debugPrint(
            '✅ Notification scheduled successfully for ${announcement.title}');
      } else {
        debugPrint(
            '❌ Failed to schedule notification for ${announcement.title}');
      }
      return;
    }

    final success = await notificationService.scheduleReminderNotification(
      announcementId: announcement.id,
      title: 'Event Reminder: ${announcement.title}',
      body: LocalNotificationService.createNotificationBody(
          announcement, announcement.reminderType ?? 'custom'),
      scheduledTime: announcement.reminderTime!,
    );

    if (success) {
      debugPrint(
          '✅ Notification scheduled successfully for ${announcement.title}');
    } else {
      debugPrint('❌ Failed to schedule notification for ${announcement.title}');
    }
  }

  // Cancel notification using LocalNotificationService
  Future<void> _cancelNotification(String announcementId) async {
    final serviceManager = ServiceManager();
    final notificationService = serviceManager.notificationService;
    if (notificationService == null) {
      debugPrint('⚠️ Cannot cancel notification - service not available');
      return;
    }

    try {
      final success =
          await notificationService.cancelNotification(announcementId);
      if (success) {
        debugPrint('✅ Notification cancelled successfully for $announcementId');
      } else {
        debugPrint('❌ Failed to cancel notification for $announcementId');
      }
    } catch (e) {
      debugPrint('❌ Error cancelling notification: $e');
    }
  }

  // Get reminder type display text
  static String getReminderTypeText(String? reminderType) {
    final lang = LanguageService.instance;
    switch (reminderType) {
      case '1_hour_before':
        return lang.getText('one_hour_before');
      case '1_day_before':
        return lang.getText('one_day_before');
      case 'custom':
        return lang.getText('custom_time');
      default:
        return lang.getText('no_reminder');
    }
  }

  // Format reminder time for display
  static String formatReminderTime(DateTime? reminderTime) {
    if (reminderTime == null) return '';

    final now = DateTime.now();
    final difference = reminderTime.difference(now);
    final lang = LanguageService.instance;

    if (difference.inDays > 0) {
      final template = lang.getText('in_days');
      return template.replaceAll('%d', difference.inDays.toString());
    } else if (difference.inHours > 0) {
      final template = lang.getText('in_hours');
      return template.replaceAll('%d', difference.inHours.toString());
    } else if (difference.inMinutes > 0) {
      final template = lang.getText('in_minutes');
      return template.replaceAll('%d', difference.inMinutes.toString());
    } else {
      return lang.getText('now');
    }
  }

  // Format complete reminder info for display
  static String formatCompleteReminderInfo(
      String? reminderType, DateTime? reminderTime) {
    if (reminderType == null || reminderTime == null) return '';

    final typeText = getReminderTypeText(reminderType);
    final timeText = formatReminderTime(reminderTime);
    final lang = LanguageService.instance;
    final notificationWord = lang.getText('notification');
    return '$typeText ($notificationWord $timeText)';
  }

  // Initialize service and load persisted reminders
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _loadRemindersFromStorage();
    _isInitialized = true;
    debugPrint(
        '📱 ReminderService initialized with ${_reminders.length} persisted reminders');
  }

  // Save reminders to SharedPreferences
  Future<void> _saveRemindersToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert reminders to JSON
      final remindersJson = <String, dynamic>{};
      final reminderTimesJson = <String, String>{};

      for (final entry in _reminders.entries) {
        remindersJson[entry.key] = entry.value.toJson();
        if (entry.value.reminderTime != null) {
          reminderTimesJson[entry.key] =
              entry.value.reminderTime!.toIso8601String();
        }
      }

      await prefs.setString(_remindersKey, jsonEncode(remindersJson));
      await prefs.setString(_reminderTimesKey, jsonEncode(reminderTimesJson));

      debugPrint('💾 Saved ${_reminders.length} reminders to storage');
    } catch (e) {
      debugPrint('❌ Error saving reminders to storage: $e');
    }
  }

  // Load reminders from SharedPreferences
  Future<void> _loadRemindersFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final remindersJsonString = prefs.getString(_remindersKey);
      final reminderTimesJsonString = prefs.getString(_reminderTimesKey);

      if (remindersJsonString != null && reminderTimesJsonString != null) {
        final remindersJson =
            jsonDecode(remindersJsonString) as Map<String, dynamic>;
        final reminderTimesJson =
            jsonDecode(reminderTimesJsonString) as Map<String, dynamic>;

        _reminders.clear();

        for (final entry in remindersJson.entries) {
          try {
            final announcement =
                Announcement.fromJson(entry.value as Map<String, dynamic>);

            // Restore reminder time if available
            if (reminderTimesJson.containsKey(entry.key)) {
              final reminderTimeString = reminderTimesJson[entry.key] as String;
              final reminderTime = DateTime.parse(reminderTimeString);

              // Only keep future reminders
              if (reminderTime.isAfter(DateTime.now())) {
                final updatedAnnouncement = Announcement(
                  id: announcement.id,
                  title: announcement.title,
                  postedDate: announcement.postedDate,
                  what: announcement.what,
                  when: announcement.when,
                  where: announcement.where,
                  category: announcement.category,
                  department: announcement.department,
                  iconType: announcement.iconType,
                  hasReminder: announcement.hasReminder,
                  hasListen: announcement.hasListen,
                  backgroundColor: announcement.backgroundColor,
                  isReminderSet: true,
                  reminderTime: reminderTime,
                  reminderType: announcement.reminderType,
                );

                _reminders[entry.key] = updatedAnnouncement;
              }
            }
          } catch (e) {
            debugPrint('⚠️ Error loading reminder ${entry.key}: $e');
          }
        }

        debugPrint('📱 Loaded ${_reminders.length} reminders from storage');

        // Clean up expired reminders
        await _cleanupExpiredReminders();
      }
    } catch (e) {
      debugPrint('❌ Error loading reminders from storage: $e');
    }
  }

  // Clean up expired reminders
  Future<void> _cleanupExpiredReminders() async {
    final now = DateTime.now();
    final expiredIds = <String>[];

    for (final entry in _reminders.entries) {
      if (entry.value.reminderTime != null &&
          entry.value.reminderTime!.isBefore(now)) {
        expiredIds.add(entry.key);
      }
    }

    for (final id in expiredIds) {
      _reminders.remove(id);
    }

    if (expiredIds.isNotEmpty) {
      await _saveRemindersToStorage();
      debugPrint('🧹 Cleaned up ${expiredIds.length} expired reminders');
    }
  }
}
