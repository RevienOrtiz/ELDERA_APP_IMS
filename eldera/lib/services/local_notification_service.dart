import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/announcement.dart';
import 'package:eldera/services/language_service.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize the notification service
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Initialize timezone data
      tz.initializeTimeZones();

      // Android initialization settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      // Combined initialization settings
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      // Initialize the plugin
      final bool? result = await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _isInitialized = result ?? false;

      if (_isInitialized) {
        await _requestPermissions();
        await _createNotificationChannels();
      }

      return _isInitialized;
    } catch (e) {
      debugPrint('Error initializing notifications: $e');
      return false;
    }
  }

  /// Create notification channels with wake-up configuration
  Future<void> _createNotificationChannels() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      // Create reminder channel with wake-up capabilities
      const AndroidNotificationChannel reminderChannel =
          AndroidNotificationChannel(
        'reminder_channel',
        'Event Reminders',
        description: 'Notifications for event reminders',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        ledColor: Colors.red,
        showBadge: true,
      );

      // Create immediate notification channel with wake-up capabilities
      const AndroidNotificationChannel immediateChannel =
          AndroidNotificationChannel(
        'immediate_channel',
        'Immediate Notifications',
        description: 'Immediate notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        ledColor: Colors.red,
        showBadge: true,
      );

      await androidImplementation.createNotificationChannel(reminderChannel);
      await androidImplementation.createNotificationChannel(immediateChannel);

      debugPrint('✅ Notification channels created with wake-up configuration');
    }
  }

  /// Request notification permissions
  Future<bool> _requestPermissions() async {
    try {
      // Request permissions for Android 13+
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? granted =
            await androidImplementation.requestNotificationsPermission();
        return granted ?? false;
      }

      // For iOS, permissions are requested during initialization
      return true;
    } catch (e) {
      debugPrint('Error requesting permissions: $e');
      return false;
    }
  }

  /// Public method to request permissions (for external use)
  Future<bool> requestPermissions() async {
    return await _requestPermissions();
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse notificationResponse) {
    debugPrint('Notification tapped: ${notificationResponse.payload}');
    // Handle notification tap - could navigate to specific screen
    // This could be expanded to parse the payload and navigate accordingly
  }

  /// Check if exact alarm permissions are granted (Android 12+)
  Future<bool> canScheduleExactAlarms() async {
    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? canSchedule =
            await androidImplementation.canScheduleExactNotifications();
        debugPrint('🔔 Exact alarm permission status: ${canSchedule ?? false}');

        if (!(canSchedule ?? false)) {
          debugPrint('⚠️ Exact alarm permission not granted');
          debugPrint(
              '   Please enable "Alarms & reminders" permission for this app');
          debugPrint(
              '   Go to: Settings → Apps → Eldera → Permissions or Special access');
        }

        return canSchedule ?? false;
      }
      return true; // Assume true for other platforms
    } catch (e) {
      debugPrint('❌ Error checking exact alarm permission: $e');
      return false;
    }
  }

  /// Request exact alarm permission with guidance (Android 12+)
  Future<void> requestExactAlarmPermissionWithGuidance() async {
    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final canSchedule = await canScheduleExactAlarms();

        if (!canSchedule) {
          debugPrint('🔔 Requesting exact alarm permission...');

          await androidImplementation.requestExactAlarmsPermission();

          // Check again after request
          final canScheduleAfter = await canScheduleExactAlarms();

          if (!canScheduleAfter) {
            debugPrint('⚠️ MANUAL ACTION REQUIRED:');
            debugPrint('   1. Go to Settings → Apps → Eldera');
            debugPrint('   2. Look for "Special app access" or "Permissions"');
            debugPrint(
                '   3. Find "Alarms & reminders" or "Schedule exact alarm"');
            debugPrint('   4. Enable the permission');
            debugPrint('   5. Restart the app');
          } else {
            debugPrint('✅ Exact alarm permission granted successfully');
          }
        }
      }
    } catch (e) {
      debugPrint('❌ Error requesting exact alarm permission: $e');
    }
  }

  /// Schedule a notification for an announcement reminder
  Future<bool> scheduleReminderNotification({
    required String announcementId,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Scheduling notification for announcement

    if (!_isInitialized) {
      // Initialize notification service if needed
      final initialized = await initialize();
      if (!initialized) {
        debugPrint('❌ Failed to initialize notification service');
        return false;
      }
    }

    try {
      // Check permissions first
      final notificationsEnabled = await areNotificationsEnabled();
      final canScheduleExact = await canScheduleExactAlarms();

      debugPrint('🔔 Permission Status:');
      debugPrint('   📱 Notifications enabled: $notificationsEnabled');
      debugPrint('   ⏰ Can schedule exact alarms: $canScheduleExact');

      if (!notificationsEnabled) {
        debugPrint('❌ Notifications are not enabled');
        return false;
      }

      if (!canScheduleExact) {
        debugPrint('⚠️ Exact alarm permission not granted - requesting...');
        final granted = await requestExactAlarmPermission();
        if (!granted) {
          debugPrint('❌ Exact alarm permission denied');
          return false;
        }
      }

      // Convert DateTime to TZDateTime
      final tz.TZDateTime scheduledTZTime =
          tz.TZDateTime.from(scheduledTime, tz.local);
      final tz.TZDateTime nowTZ = tz.TZDateTime.now(tz.local);

      // Debug logging for notification scheduling
      debugPrint('🔔 Scheduling notification:');
      debugPrint('   📅 Current time: $nowTZ');
      debugPrint('   ⏰ Scheduled time: $scheduledTZTime');
      debugPrint('   📱 Announcement ID: $announcementId');
      debugPrint('   🏷️ Title: $title');

      // Check if the scheduled time is in the future
      if (scheduledTZTime.isBefore(nowTZ)) {
        debugPrint('❌ Cannot schedule notification in the past');
        debugPrint('   Current: $nowTZ');
        debugPrint('   Scheduled: $scheduledTZTime');
        return false;
      }

      final timeDifference = scheduledTZTime.difference(nowTZ);
      debugPrint(
          '   ⏳ Time until notification: ${timeDifference.inMinutes} minutes');

      // Create notification details
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'reminder_channel',
        'Event Reminders',
        channelDescription: 'Notifications for event reminders',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        visibility: NotificationVisibility.public,
        enableLights: true,
        ledColor: Colors.red,
        ledOnMs: 1000,
        ledOffMs: 500,
      );

      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      // Schedule the notification
      final notificationId = announcementId.hashCode;
      debugPrint('   🆔 Notification ID: $notificationId');

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId, // Use announcement ID hash as notification ID
        title,
        body,
        scheduledTZTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: announcementId,
      );

      debugPrint('✅ Notification scheduled successfully!');
      debugPrint('   📋 Payload: $announcementId');

      // Verify the notification was scheduled by checking pending notifications
      final pendingNotifications = await getPendingNotifications();
      final scheduledNotification = pendingNotifications
          .where((notification) => notification.id == notificationId)
          .firstOrNull;

      if (scheduledNotification != null) {
        debugPrint('✅ Verified: Notification is in pending list');
        debugPrint(
            '   📋 Pending notification: ${scheduledNotification.title}');
      } else {
        debugPrint('⚠️ Warning: Notification not found in pending list');
        debugPrint(
            '   📊 Total pending notifications: ${pendingNotifications.length}');
      }

      return true;
    } catch (e) {
      debugPrint('❌ Error scheduling notification: $e');
      return false;
    }
  }

  /// Cancel a scheduled notification
  Future<bool> cancelNotification(String announcementId) async {
    if (!_isInitialized) return false;

    try {
      await _flutterLocalNotificationsPlugin.cancel(announcementId.hashCode);
      // Notification cancelled
      return true;
    } catch (e) {
      debugPrint('Error cancelling notification: $e');
      return false;
    }
  }

  /// Cancel all notifications
  Future<bool> cancelAllNotifications() async {
    if (!_isInitialized) return false;

    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
      // All notifications cancelled
      return true;
    } catch (e) {
      debugPrint('Error cancelling all notifications: $e');
      return false;
    }
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_isInitialized) return [];

    try {
      return await _flutterLocalNotificationsPlugin
          .pendingNotificationRequests();
    } catch (e) {
      debugPrint('Error getting pending notifications: $e');
      return [];
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? enabled =
            await androidImplementation.areNotificationsEnabled();
        // Checked notification permissions
        return enabled ?? false;
      }
      return true; // Assume enabled for other platforms
    } catch (e) {
      debugPrint('Error checking notification permissions: $e');
      return false;
    }
  }

  /// Request exact alarm permissions (Android 12+)
  Future<bool> requestExactAlarmPermission() async {
    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      if (androidImplementation != null) {
        final bool? granted =
            await androidImplementation.requestExactAlarmsPermission();
        // Checked exact alarm permission
        return granted ?? false;
      }
      return true;
    } catch (e) {
      debugPrint('Error requesting exact alarm permission: $e');
      return false;
    }
  }

  /// Show an immediate notification
  Future<bool> showImmediateNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('🔔 showImmediateNotification called');
    debugPrint('   Title: $title');
    debugPrint('   Body: $body');
    debugPrint('   Initialized: $_isInitialized');

    if (!_isInitialized) {
      debugPrint(
          '   Notification service not initialized, attempting to initialize...');
      final initialized = await initialize();
      debugPrint('   Initialization result: $initialized');
      if (!initialized) {
        debugPrint('❌ Failed to initialize notification service');
        return false;
      }
    }

    // Check permissions before showing notification
    final permissionsGranted = await areNotificationsEnabled();
    debugPrint('   Notifications enabled: $permissionsGranted');

    if (!permissionsGranted) {
      debugPrint('❌ Notifications not enabled, requesting permissions...');
      await _requestPermissions();
      final permissionsAfterRequest = await areNotificationsEnabled();
      debugPrint('   Permissions after request: $permissionsAfterRequest');
      if (!permissionsAfterRequest) {
        debugPrint('❌ Notification permissions still not granted');
        return false;
      }
    }

    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'immediate_channel',
        'Immediate Notifications',
        channelDescription: 'Immediate notifications',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        visibility: NotificationVisibility.public,
        enableLights: true,
        ledColor: Colors.red,
        ledOnMs: 1000,
        ledOffMs: 500,
      );

      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      final notificationId =
          DateTime.now().millisecondsSinceEpoch.remainder(100000);
      debugPrint('   Showing notification with ID: $notificationId');

      await _flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        body,
        platformChannelSpecifics,
        payload: payload,
      );

      debugPrint('✅ Immediate notification shown successfully');
      return true;
    } catch (e) {
      debugPrint('❌ Error showing immediate notification: $e');
      return false;
    }
  }

  /// Helper method to create notification content from announcement
  static String createNotificationBody(
      Announcement announcement, String reminderType) {
    final timeText = _getReminderTimeText(reminderType);
    return '${LanguageService.instance.translateFreeText(announcement.what)} is starting $timeText at ${announcement.where}';
  }

  static String _getReminderTimeText(String reminderType) {
    switch (reminderType) {
      case '1_hour_before':
        return 'in 1 hour';
      case '1_day_before':
        return 'tomorrow';
      case 'custom':
        return 'soon';
      default:
        return 'soon';
    }
  }
}
