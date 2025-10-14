import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../utils/memory_optimizer.dart';
import '../utils/secure_logger.dart';

/// Performance monitoring service for low-end devices
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  // Performance metrics
  final Map<String, DateTime> _operationStartTimes = {};
  final Map<String, List<Duration>> _operationDurations = {};
  final List<Map<String, dynamic>> _warnings = [];
  final List<double> _frameTimings = [];
  final Map<String, Duration> _operationTimes = {};
  
  // Memory tracking
  int _lastMemoryUsage = 0;
  Timer? _memoryMonitorTimer;
  DateTime? _startTime;
  
  // Network tracking
  final Map<String, int> _networkCallCounts = {};
  final Map<String, List<Duration>> _networkResponseTimes = {};
  
  bool _isMonitoring = false;

  /// Initialize performance monitoring
  void initialize() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _startTime = DateTime.now();
    SecureLogger.info('Performance monitoring initialized for ${MemoryOptimizer.isBudgetDevice() ? "budget" : "standard"} device');
    
    // Start memory monitoring for budget devices
    if (MemoryOptimizer.isBudgetDevice()) {
      _startMemoryMonitoring();
    }
    
    // Set up frame callback for UI performance monitoring
    _setupFrameMonitoring();
  }

  /// Start monitoring memory usage
  void _startMemoryMonitoring() {
    _memoryMonitorTimer = Timer.periodic(
      const Duration(seconds: 30), // Check every 30 seconds
      (timer) => _checkMemoryUsage(),
    );
  }

  /// Setup frame monitoring for UI performance
  void _setupFrameMonitoring() {
    if (kDebugMode) {
      SchedulerBinding.instance.addTimingsCallback(_onFrameTimings);
    }
  }

  /// Handle frame timing data
  void _onFrameTimings(List<FrameTiming> timings) {
    if (!MemoryOptimizer.isBudgetDevice()) return;
    
    for (final timing in timings) {
      final frameDuration = timing.totalSpan;
      
      // Warn if frame takes longer than 16.67ms (60fps threshold)
      if (frameDuration.inMicroseconds > 16670) {
        _addPerformanceWarning(
          'Slow frame detected: ${frameDuration.inMilliseconds}ms'
        );
      }
      
      // Critical warning for very slow frames (>33ms = 30fps)
      if (frameDuration.inMicroseconds > 33000) {
        SecureLogger.warning('Critical frame drop: ${frameDuration.inMilliseconds}ms');
      }
    }
  }

  /// Check current memory usage
  Future<void> _checkMemoryUsage() async {
    try {
      // This is a simplified memory check
      // In a real implementation, you might use platform channels
      // to get actual memory usage from native code
      
      final currentTime = DateTime.now();
      
      // Simulate memory pressure detection
      if (MemoryOptimizer.isBudgetDevice()) {
        // Request garbage collection periodically on budget devices
        MemoryOptimizer.requestGarbageCollection();
        
        SecureLogger.info('Memory check completed at ${currentTime.toIso8601String()}');
      }
    } catch (e) {
      SecureLogger.error('Memory check failed: $e');
    }
  }

  /// Start tracking an operation
  void startOperation(String operationName) {
    _operationStartTimes[operationName] = DateTime.now();
    SecureLogger.info('Started operation: $operationName');
  }

  /// End tracking an operation
  void endOperation(String operationName) {
    final startTime = _operationStartTimes.remove(operationName);
    if (startTime == null) {
      SecureLogger.warning('Attempted to end untracked operation: $operationName');
      return;
    }
    
    final duration = DateTime.now().difference(startTime);
    
    // Store duration for analysis
    _operationDurations.putIfAbsent(operationName, () => []).add(duration);
    
    // Log slow operations
    if (duration.inMilliseconds > 1000) {
      _addPerformanceWarning('Slow operation: $operationName took ${duration.inMilliseconds}ms');
    }
    
    SecureLogger.info('Completed operation: $operationName in ${duration.inMilliseconds}ms');
  }

  /// Track network call
  void trackNetworkCall(String endpoint, Duration responseTime) {
    _networkCallCounts[endpoint] = (_networkCallCounts[endpoint] ?? 0) + 1;
    _networkResponseTimes.putIfAbsent(endpoint, () => []).add(responseTime);
    
    // Warn about slow network calls
    if (responseTime.inMilliseconds > 5000) {
      _addPerformanceWarning('Slow network call: $endpoint took ${responseTime.inMilliseconds}ms');
    }
    
    SecureLogger.info('Network call to $endpoint completed in ${responseTime.inMilliseconds}ms');
  }

  /// Add performance warning
  void _addPerformanceWarning(String warning) {
    _warnings.add({
      'timestamp': DateTime.now().toIso8601String(),
      'message': warning,
    });
    
    // Keep only last 50 warnings to prevent memory bloat
    if (_warnings.length > 50) {
      _warnings.removeAt(0);
    }
    
    SecureLogger.warning('Performance Warning: $warning');
  }

  /// Get performance statistics
  Map<String, dynamic> getPerformanceStats() {
    final stats = <String, dynamic>{
      'device_type': MemoryOptimizer.isBudgetDevice() ? 'budget' : 'standard',
      'monitoring_active': _isMonitoring,
      'warnings_count': _warnings.length,
      'operations_tracked': _operationDurations.length,
      'network_endpoints_called': _networkCallCounts.length,
    };
    
    // Add operation statistics
    final operationStats = <String, Map<String, dynamic>>{};
    _operationDurations.forEach((operation, durations) {
      if (durations.isNotEmpty) {
        final avgDuration = durations.map((d) => d.inMilliseconds).reduce((a, b) => a + b) / durations.length;
        final maxDuration = durations.map((d) => d.inMilliseconds).reduce((a, b) => a > b ? a : b);
        
        operationStats[operation] = {
          'count': durations.length,
          'avg_duration_ms': avgDuration.round(),
          'max_duration_ms': maxDuration,
        };
      }
    });
    stats['operations'] = operationStats;
    
    // Add network statistics
    final networkStats = <String, Map<String, dynamic>>{};
    _networkResponseTimes.forEach((endpoint, times) {
      if (times.isNotEmpty) {
        final avgTime = times.map((t) => t.inMilliseconds).reduce((a, b) => a + b) / times.length;
        final maxTime = times.map((t) => t.inMilliseconds).reduce((a, b) => a > b ? a : b);
        
        networkStats[endpoint] = {
          'call_count': _networkCallCounts[endpoint] ?? 0,
          'avg_response_time_ms': avgTime.round(),
          'max_response_time_ms': maxTime,
        };
      }
    });
    stats['network'] = networkStats;
    
    return stats;
  }

  /// Get recent performance warnings
  List<String> getRecentWarnings({int limit = 10}) {
    final warnings = _warnings.map((w) => '${w['timestamp']}: ${w['message']}').toList();
    if (warnings.length > limit) {
      return warnings.sublist(warnings.length - limit);
    }
    return warnings;
  }

  /// Check if device is experiencing performance issues
  bool isPerformanceIssueDetected() {
    // Check for recent warnings
    final recentWarnings = getRecentWarnings(limit: 5);
    if (recentWarnings.length >= 3) {
      return true;
    }
    
    // Check for consistently slow operations
    for (final durations in _operationDurations.values) {
      if (durations.length >= 3) {
        final recentDurations = durations.sublist(durations.length - 3);
        final avgDuration = recentDurations.map((d) => d.inMilliseconds).reduce((a, b) => a + b) / 3;
        if (avgDuration > 2000) { // 2 seconds average
          return true;
        }
      }
    }
    
    return false;
  }

  /// Optimize performance based on current conditions
  Future<void> optimizePerformance() async {
    if (!MemoryOptimizer.isBudgetDevice()) return;
    
    SecureLogger.info('Starting performance optimization...');
    
    try {
      // Clear old performance data to free memory
      _clearOldData();
      
      // Request garbage collection
      MemoryOptimizer.requestGarbageCollection();
      
      // Reduce image cache if needed
      MemoryOptimizer.reduceImageCacheSize();
      
      SecureLogger.info('Performance optimization completed');
    } catch (e) {
      SecureLogger.error('Performance optimization failed: $e');
    }
  }

  /// Clear old performance data
  void _clearOldData() {
    // Keep only recent operation data
    _operationDurations.forEach((key, durations) {
      if (durations.length > 10) {
        _operationDurations[key] = durations.sublist(durations.length - 10);
      }
    });
    
    // Keep only recent network data
    _networkResponseTimes.forEach((key, times) {
      if (times.length > 10) {
        _networkResponseTimes[key] = times.sublist(times.length - 10);
      }
    });
    
    // Clear old warnings
    if (_warnings.length > 20) {
      _warnings.removeRange(0, _warnings.length - 20);
    }
  }

  /// Generate performance report
  String generatePerformanceReport() {
    final stats = getPerformanceStats();
    final warnings = getRecentWarnings();
    
    final report = StringBuffer();
    report.writeln('=== ELDERA Performance Report ===');
    report.writeln('Device Type: ${stats['device_type']}');
    report.writeln('Monitoring Active: ${stats['monitoring_active']}');
    report.writeln('Total Warnings: ${stats['warnings_count']}');
    report.writeln('Operations Tracked: ${stats['operations_tracked']}');
    report.writeln('Network Endpoints: ${stats['network_endpoints_called']}');
    report.writeln('');
    
    if (warnings.isNotEmpty) {
      report.writeln('Recent Warnings:');
      for (final warning in warnings) {
        report.writeln('  - $warning');
      }
      report.writeln('');
    }
    
    report.writeln('Performance Issue Detected: ${isPerformanceIssueDetected()}');
    
    return report.toString();
  }

  /// Add missing methods that are called by other services
  void logWarning(String message) {
    debugPrint('Performance Warning: $message');
    _warnings.add({
      'message': message,
      'timestamp': DateTime.now(),
    });
    
    // Keep only recent warnings to save memory
    if (_warnings.length > 50) {
      _warnings.removeRange(0, _warnings.length - 50);
    }
  }
  
  void reduceMonitoringFrequency() {
    // Reduce monitoring frequency for low-end devices
    _memoryMonitorTimer?.cancel();
    _memoryMonitorTimer = Timer.periodic(
      const Duration(seconds: 60), // Increased from 30 seconds
      (timer) => _checkMemoryUsage(),
    );
  }
  
  Map<String, dynamic> generateReport() {
    return {
      'monitoring_active': _isMonitoring,
      'uptime_minutes': _startTime != null 
          ? DateTime.now().difference(_startTime!).inMinutes 
          : 0,
      'average_frame_time': _frameTimings.isNotEmpty 
          ? _frameTimings.reduce((a, b) => a + b) / _frameTimings.length 
          : 0.0,
      'warnings_count': _warnings.length,
      'operations_tracked': _operationTimes.length,
    };
  }

  /// Dispose resources
  void dispose() {
    _memoryMonitorTimer?.cancel();
    _operationStartTimes.clear();
    _operationDurations.clear();
    _networkCallCounts.clear();
    _networkResponseTimes.clear();
    _warnings.clear();
    _frameTimings.clear();
    _operationTimes.clear();
    _isMonitoring = false;
    
    SecureLogger.info('Performance monitor disposed');
  }
}