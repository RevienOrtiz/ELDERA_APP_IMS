import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/memory_optimizer.dart';
import 'performance_monitor.dart';

/// Comprehensive error handling service optimized for low-end devices
class ErrorHandlerService {
  static final ErrorHandlerService _instance = ErrorHandlerService._internal();
  factory ErrorHandlerService() => _instance;
  ErrorHandlerService._internal();

  static ErrorHandlerService get instance => _instance;

  final List<ErrorReport> _errorHistory = [];
  final StreamController<ErrorReport> _errorStreamController = StreamController<ErrorReport>.broadcast();
  
  Timer? _errorCleanupTimer;
  int _maxErrorHistory = 50; // Reduced for low-end devices
  
  /// Initialize error handling service
  void initialize() {
    // Set up global error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      _handleFlutterError(details);
    };

    // Handle platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      _handlePlatformError(error, stack);
      return true;
    };

    // Start periodic cleanup for low-end devices
    _startErrorCleanup();
    
    // Adjust settings for budget devices
    if (MemoryOptimizer.isBudgetDevice()) {
      _maxErrorHistory = 25;
    }
  }

  /// Handle Flutter framework errors
  void _handleFlutterError(FlutterErrorDetails details) {
    final errorReport = ErrorReport(
      type: ErrorType.flutter,
      message: details.exception.toString(),
      stackTrace: details.stack?.toString(),
      timestamp: DateTime.now(),
      context: details.context?.toString(),
      library: details.library,
    );

    _recordError(errorReport);

    // Log to console in debug mode
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  }

  /// Handle platform-specific errors
  void _handlePlatformError(Object error, StackTrace stack) {
    final errorReport = ErrorReport(
      type: ErrorType.platform,
      message: error.toString(),
      stackTrace: stack.toString(),
      timestamp: DateTime.now(),
    );

    _recordError(errorReport);

    // Log to console in debug mode
    if (kDebugMode) {
      debugPrint('Platform Error: $error\n$stack');
    }
  }

  /// Handle network-related errors
  void handleNetworkError(Object error, {String? context, StackTrace? stackTrace}) {
    final errorReport = ErrorReport(
      type: ErrorType.network,
      message: error.toString(),
      stackTrace: stackTrace?.toString(),
      timestamp: DateTime.now(),
      context: context,
    );

    _recordError(errorReport);
  }

  /// Handle memory-related errors
  void handleMemoryError(Object error, {String? context, StackTrace? stackTrace}) {
    final errorReport = ErrorReport(
      type: ErrorType.memory,
      message: error.toString(),
      stackTrace: stackTrace?.toString(),
      timestamp: DateTime.now(),
      context: context,
    );

    _recordError(errorReport);

    // Trigger memory cleanup on low-end devices
    if (MemoryOptimizer.isBudgetDevice()) {
      MemoryOptimizer.performEmergencyCleanup();
    }
  }

  /// Handle API-related errors
  void handleApiError(Object error, {String? endpoint, int? statusCode, StackTrace? stackTrace}) {
    final errorReport = ErrorReport(
      type: ErrorType.api,
      message: error.toString(),
      stackTrace: stackTrace?.toString(),
      timestamp: DateTime.now(),
      context: 'Endpoint: $endpoint, Status: $statusCode',
    );

    _recordError(errorReport);
  }

  /// Handle UI-related errors
  void handleUiError(Object error, {String? widget, StackTrace? stackTrace}) {
    final errorReport = ErrorReport(
      type: ErrorType.ui,
      message: error.toString(),
      stackTrace: stackTrace?.toString(),
      timestamp: DateTime.now(),
      context: 'Widget: $widget',
    );

    _recordError(errorReport);
  }

  /// Record error and manage history
  void _recordError(ErrorReport errorReport) {
    _errorHistory.add(errorReport);
    _errorStreamController.add(errorReport);

    // Limit history size for memory efficiency
    if (_errorHistory.length > _maxErrorHistory) {
      _errorHistory.removeRange(0, _errorHistory.length - _maxErrorHistory);
    }

    // Log critical errors
    if (errorReport.isCritical) {
      _logCriticalError(errorReport);
    }
  }

  /// Log critical errors that need immediate attention
  void _logCriticalError(ErrorReport errorReport) {
    debugPrint('CRITICAL ERROR [${errorReport.type.name}]: ${errorReport.message}');
    
    // On low-end devices, trigger performance optimization
    if (MemoryOptimizer.isBudgetDevice()) {
      PerformanceMonitor().logWarning('Critical error detected: ${errorReport.message}');
    }
  }

  /// Start periodic cleanup of old errors
  void _startErrorCleanup() {
    _errorCleanupTimer = Timer.periodic(
      Duration(minutes: MemoryOptimizer.isBudgetDevice() ? 5 : 10),
      (timer) => _cleanupOldErrors(),
    );
  }

  /// Clean up old errors to free memory
  void _cleanupOldErrors() {
    final cutoffTime = DateTime.now().subtract(
      Duration(hours: MemoryOptimizer.isBudgetDevice() ? 1 : 2),
    );

    _errorHistory.removeWhere((error) => error.timestamp.isBefore(cutoffTime));
  }

  /// Get error statistics
  ErrorStatistics getErrorStatistics() {
    final now = DateTime.now();
    final last24Hours = now.subtract(const Duration(hours: 24));
    final lastHour = now.subtract(const Duration(hours: 1));

    final recent24h = _errorHistory.where((e) => e.timestamp.isAfter(last24Hours)).toList();
    final recentHour = _errorHistory.where((e) => e.timestamp.isAfter(lastHour)).toList();

    return ErrorStatistics(
      totalErrors: _errorHistory.length,
      errorsLast24Hours: recent24h.length,
      errorsLastHour: recentHour.length,
      criticalErrors: _errorHistory.where((e) => e.isCritical).length,
      errorsByType: _groupErrorsByType(_errorHistory),
      mostCommonError: _getMostCommonError(),
    );
  }

  /// Group errors by type for analysis
  Map<ErrorType, int> _groupErrorsByType(List<ErrorReport> errors) {
    final Map<ErrorType, int> grouped = {};
    for (final error in errors) {
      grouped[error.type] = (grouped[error.type] ?? 0) + 1;
    }
    return grouped;
  }

  /// Get the most common error message
  String? _getMostCommonError() {
    if (_errorHistory.isEmpty) return null;

    final Map<String, int> errorCounts = {};
    for (final error in _errorHistory) {
      errorCounts[error.message] = (errorCounts[error.message] ?? 0) + 1;
    }

    return errorCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Show error dialog for debugging (only in debug mode)
  void showErrorDialog(BuildContext context, ErrorReport error) {
    if (!kDebugMode) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error [${error.type.name}]'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Message: ${error.message}'),
              if (error.context != null) ...[
                const SizedBox(height: 8),
                Text('Context: ${error.context}'),
              ],
              if (error.stackTrace != null) ...[
                const SizedBox(height: 8),
                Text('Stack Trace:', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(error.stackTrace!, style: const TextStyle(fontSize: 12)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Get error stream for listening to new errors
  Stream<ErrorReport> get errorStream => _errorStreamController.stream;

  /// Get recent errors
  List<ErrorReport> getRecentErrors({int limit = 10}) {
    final sorted = List<ErrorReport>.from(_errorHistory)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(limit).toList();
  }

  /// Clear error history
  void clearErrorHistory() {
    _errorHistory.clear();
  }

  /// Dispose resources
  void dispose() {
    _errorCleanupTimer?.cancel();
    _errorStreamController.close();
  }
}

/// Error report model
class ErrorReport {
  final ErrorType type;
  final String message;
  final String? stackTrace;
  final DateTime timestamp;
  final String? context;
  final String? library;

  ErrorReport({
    required this.type,
    required this.message,
    this.stackTrace,
    required this.timestamp,
    this.context,
    this.library,
  });

  bool get isCritical {
    return type == ErrorType.memory ||
           type == ErrorType.platform ||
           message.toLowerCase().contains('out of memory') ||
           message.toLowerCase().contains('crash');
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'message': message,
      'stackTrace': stackTrace,
      'timestamp': timestamp.toIso8601String(),
      'context': context,
      'library': library,
      'isCritical': isCritical,
    };
  }
}

/// Error type enumeration
enum ErrorType {
  flutter,
  platform,
  network,
  memory,
  api,
  ui,
  unknown,
}

/// Error statistics model
class ErrorStatistics {
  final int totalErrors;
  final int errorsLast24Hours;
  final int errorsLastHour;
  final int criticalErrors;
  final Map<ErrorType, int> errorsByType;
  final String? mostCommonError;

  ErrorStatistics({
    required this.totalErrors,
    required this.errorsLast24Hours,
    required this.errorsLastHour,
    required this.criticalErrors,
    required this.errorsByType,
    this.mostCommonError,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalErrors': totalErrors,
      'errorsLast24Hours': errorsLast24Hours,
      'errorsLastHour': errorsLastHour,
      'criticalErrors': criticalErrors,
      'errorsByType': errorsByType.map((k, v) => MapEntry(k.name, v)),
      'mostCommonError': mostCommonError,
    };
  }
}