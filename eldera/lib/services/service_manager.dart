import 'package:flutter/foundation.dart';
import 'ims_webhook_handler.dart';
import 'local_notification_service.dart';
import 'language_service.dart';
import 'reminder_service.dart';
import '../utils/memory_optimizer.dart';
import '../services/local_database_service.dart';

/// Manages lazy loading and initialization of app services
/// Optimized for budget devices with limited resources
class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  factory ServiceManager() => _instance;
  ServiceManager._internal();

  // Service initialization status
  bool _webhookInitialized = false;
  bool _notificationInitialized = false;
  bool _languageInitialized = false;
  bool _reminderInitialized = false;

  // Service instances (lazy loaded)
  LocalNotificationService? _notificationService;
  ReminderService? _reminderService;

  // Initialization progress tracking
  double _initializationProgress = 0.0;
  String _currentInitializationStep = 'Starting...';

  // Callbacks for progress updates
  final List<Function(double, String)> _progressCallbacks = [];

  /// Get current initialization progress (0.0 to 1.0)
  double get initializationProgress => _initializationProgress;

  /// Get current initialization step description
  String get currentInitializationStep => _currentInitializationStep;

  /// Check if all critical services are initialized
  bool get allServicesReady =>
      _webhookInitialized &&
      _notificationInitialized &&
      _languageInitialized &&
      _reminderInitialized;

  /// Check if notifications are ready
  bool get isNotificationReady => _notificationInitialized;

  /// Add a callback to receive initialization progress updates
  void addProgressCallback(Function(double, String) callback) {
    _progressCallbacks.add(callback);
  }

  /// Remove a progress callback
  void removeProgressCallback(Function(double, String) callback) {
    _progressCallbacks.remove(callback);
  }

  /// Update initialization progress and notify callbacks
  void _updateProgress(double progress, String step) {
    _initializationProgress = progress;
    _currentInitializationStep = step;

    for (final callback in _progressCallbacks) {
      try {
        callback(progress, step);
      } catch (e) {
        debugPrint('Error in progress callback: $e');
      }
    }
  }

  /// Initialize all services in background with progress tracking
  Future<void> initializeAllServices() async {
    try {
      _updateProgress(0.05, 'Initializing local database...');
      await _initializeLocalDatabase();

      _updateProgress(0.15, 'Optimizing memory...');
      await _initializeMemoryOptimizer();

      _updateProgress(0.35, 'Initializing language service...');
      await _initializeLanguageService();

      _updateProgress(0.60, 'Configuring webhooks...');
      await _initializeWebhooks();

      _updateProgress(0.75, 'Loading reminders...');
      await _initializeReminderService();

      _updateProgress(0.90, 'Setting up notifications...');
      await _initializeNotifications();

      _updateProgress(1.0, 'Ready!');
      debugPrint('All services initialized successfully');
    } catch (e) {
      debugPrint('Service initialization error: $e');
      // Continue with partial initialization
    }
  }

  /// Initialize local database service
  Future<void> _initializeLocalDatabase() async {
    try {
      await LocalDatabaseService.initialize();
      debugPrint('✅ Local database initialized');
    } catch (e) {
      debugPrint('❌ Local database initialization failed: $e');
    }
  }

  /// Initialize memory optimizer
  Future<void> _initializeMemoryOptimizer() async {
    try {
      await MemoryOptimizer.initialize();
      await MemoryOptimizer.applyBudgetOptimizations();
      debugPrint('✅ Memory optimizer initialized');
    } catch (e) {
      debugPrint('❌ Memory optimizer initialization failed: $e');
    }
  }

  /// Initialize language service
  Future<void> _initializeLanguageService() async {
    if (_languageInitialized) return;

    try {
      await LanguageService.instance.init();
      _languageInitialized = true;
      debugPrint('✅ Language service initialized');
    } catch (e) {
      debugPrint('❌ Language service initialization failed: $e');
      _languageInitialized = true;
    }
  }

  /// Initialize webhook handler
  Future<void> _initializeWebhooks() async {
    if (_webhookInitialized) return;

    try {
      await IMSWebhookHandler.initialize();
      _webhookInitialized = true;
      debugPrint('✅ Webhook handler initialized');
    } catch (e) {
      debugPrint('❌ Webhook initialization failed: $e');
      _webhookInitialized = true;
    }
  }

  /// Initialize notification service
  Future<void> _initializeNotifications() async {
    if (_notificationInitialized) return;

    try {
      _notificationService = LocalNotificationService();
      final initialized = await _notificationService!.initialize();

      if (initialized) {
        // Check permissions in background
        final notificationsEnabled =
            await _notificationService!.areNotificationsEnabled();
        final exactAlarmPermission =
            await _notificationService!.requestExactAlarmPermission();

        debugPrint(
            '✅ Notifications initialized - Enabled: $notificationsEnabled, Exact alarms: $exactAlarmPermission');

        if (!notificationsEnabled) {
          debugPrint(
              '⚠️ Notifications not enabled - some features may be limited');
        }
        if (!exactAlarmPermission) {
          await _notificationService!
              .requestExactAlarmPermissionWithGuidance();
        }
      }

      _notificationInitialized = true;
    } catch (e) {
      debugPrint('❌ Notification initialization failed: $e');
      _notificationInitialized = true;
    }
  }

  /// Get notification service instance (lazy loaded)
  LocalNotificationService? get notificationService {
    if (!_notificationInitialized) {
      debugPrint('⚠️ Notification service not yet initialized');
      return null;
    }
    return _notificationService;
  }

  /// Get reminder service instance (lazy loaded)
  ReminderService? get reminderService {
    if (!_reminderInitialized) {
      debugPrint('⚠️ Reminder service not yet initialized');
      return null;
    }
    return _reminderService;
  }

  /// Wait for a specific service to be ready
  Future<void> waitForService(String serviceName,
      {Duration timeout = const Duration(seconds: 10)}) async {
    final startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < timeout) {
      switch (serviceName.toLowerCase()) {
        case 'webhook':
          if (_webhookInitialized) return;
          break;
        case 'notification':
          if (_notificationInitialized) return;
          break;
        case 'language':
          if (_languageInitialized) return;
          break;
        case 'all':
          // For 'all', we'll be very lenient - proceed after just 1 second or if any service is ready
          int readyServices = 0;
          if (_webhookInitialized) readyServices++;
          if (_notificationInitialized) readyServices++;
          if (_languageInitialized) readyServices++;
          if (_reminderInitialized) readyServices++;

          // If any service is ready, or if we've waited more than 1 second, proceed
          if (readyServices >= 1 ||
              DateTime.now().difference(startTime) >
                  const Duration(seconds: 1)) {
            return;
          }
          break;
      }

      await Future.delayed(const Duration(milliseconds: 50)); // Reduced delay
    }

    debugPrint('⚠️ Timeout waiting for service: $serviceName');
  }

  /// Reset all services (for testing or restart scenarios)
  void reset() {
    _webhookInitialized = false;
    _notificationInitialized = false;
    _languageInitialized = false;
    _reminderInitialized = false;
    _notificationService = null;
    _reminderService = null;
    _initializationProgress = 0.0;
    _currentInitializationStep = 'Starting...';
    _progressCallbacks.clear();
  }

  /// Initialize reminder service
  Future<void> _initializeReminderService() async {
    try {
      _reminderService = ReminderService.instance;
      await _reminderService!.initialize();
      _reminderInitialized = true;
      debugPrint('✅ ReminderService initialized');
    } catch (e) {
      debugPrint('❌ ReminderService initialization failed: $e');
      // Don't block app startup for reminder service failure
      _reminderInitialized = true; // Mark as initialized to prevent blocking
    }
  }
}
