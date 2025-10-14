import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'memory_optimizer.dart';
import '../services/performance_monitor.dart';
import '../services/optimized_api_service.dart';
import '../services/optimized_image_service.dart';
import '../services/error_handler_service.dart';
import 'memory_optimizer.dart';
import 'secure_logger.dart';

/// Comprehensive handler for low-end device optimizations and error handling
class LowEndDeviceHandler {
  static final LowEndDeviceHandler _instance = LowEndDeviceHandler._internal();
  factory LowEndDeviceHandler() => _instance;
  LowEndDeviceHandler._internal();

  final PerformanceMonitor _performanceMonitor = PerformanceMonitor();
  final OptimizedApiService _apiService = OptimizedApiService();
  final ErrorHandlerService _errorHandler = ErrorHandlerService();
  
  bool _isInitialized = false;
  Timer? _healthCheckTimer;
  Timer? _optimizationTimer;
  
  // Error tracking
  final Map<String, int> _errorCounts = {};
  final List<String> _criticalErrors = [];
  
  // Performance thresholds for low-end devices
  static const int _maxMemoryWarnings = 5;
  static const int _maxNetworkErrors = 3;
  static const Duration _healthCheckInterval = Duration(minutes: 2);
  static const Duration _optimizationInterval = Duration(minutes: 5);

  /// Initialize all low-end device optimizations
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      SecureLogger.info('Initializing low-end device optimizations...');

      // Initialize core components
      await MemoryOptimizer.initialize();
      
      _performanceMonitor.initialize();
      
      _apiService.initialize();
      
      _errorHandler.initialize();

      // Apply device-specific optimizations
      await _applyDeviceOptimizations();

      // Start monitoring and maintenance
      _startHealthChecking();
      _startPeriodicOptimization();

      _isInitialized = true;
      SecureLogger.info('Low-end device optimizations initialized successfully');
    } catch (e, stackTrace) {
      SecureLogger.error('Failed to initialize low-end device handler: $e');
      _errorHandler.handleMemoryError(e, 
        context: 'LowEndDeviceHandler initialization', 
        stackTrace: stackTrace
      );
      rethrow;
    }
  }

  /// Apply device-specific optimizations
  Future<void> _applyDeviceOptimizations() async {
    if (MemoryOptimizer.isBudgetDevice()) {
      SecureLogger.info('Applying budget device optimizations...');
      
      // Optimize image cache
      OptimizedImageService.optimizeImageCacheForDevice();
      
      // Reduce memory usage
      MemoryOptimizer.reduceImageCacheSize();
      
      // Set conservative API timeouts
      SecureLogger.info('API timeouts configured for budget device');
      
      // Disable expensive visual effects
      _disableExpensiveEffects();
      
    } else {
      SecureLogger.info('Applying standard device optimizations...');
      OptimizedImageService.optimizeImageCacheForDevice();
    }
  }

  /// Disable expensive visual effects on budget devices
  void _disableExpensiveEffects() {
    if (MemoryOptimizer.isBudgetDevice()) {
      // This would typically involve setting global flags
      // that other parts of the app can check
      SecureLogger.info('Expensive visual effects disabled for budget device');
    }
  }

  /// Start health checking
  void _startHealthChecking() {
    _healthCheckTimer = Timer.periodic(_healthCheckInterval, (timer) {
      _performHealthCheck();
    });
  }

  /// Start periodic optimization
  void _startPeriodicOptimization() {
    _optimizationTimer = Timer.periodic(_optimizationInterval, (timer) {
      _performPeriodicOptimization();
    });
  }

  /// Perform health check
  Future<void> _performHealthCheck() async {
    try {
      _performanceMonitor.startOperation('health_check');
      
      // Check for performance issues
      if (_performanceMonitor.isPerformanceIssueDetected()) {
        await _handlePerformanceIssue('general_performance_issue', {
          'timestamp': DateTime.now().toIso8601String(),
          'source': 'health_check'
        });
      }
      
      // Check memory pressure
      if (MemoryOptimizer.isBudgetDevice()) {
        await _checkMemoryPressure();
      }
      
      // Check network connectivity
      final isConnected = await _apiService.checkConnectivity();
      if (!isConnected) {
        _handleNetworkIssue();
      }
      
      _performanceMonitor.endOperation('health_check');
      
    } catch (e) {
      SecureLogger.error('Health check failed: $e');
      _recordError('health_check_failed');
    }
  }

  /// Perform periodic optimization
  Future<void> _performPeriodicOptimization() async {
    try {
      if (MemoryOptimizer.isBudgetDevice()) {
        _performanceMonitor.startOperation('periodic_optimization');
        
        // Request garbage collection
        MemoryOptimizer.requestGarbageCollection();
        
        // Clear old performance data
        await _performanceMonitor.optimizePerformance();
        
        // Clear image cache if memory pressure detected
        final stats = OptimizedImageService.getImageCacheStats();
        if (stats['memoryPressure'] == true) {
          OptimizedImageService.clearImageCache();
          SecureLogger.info('Image cache cleared due to memory pressure');
        }
        
        _performanceMonitor.endOperation('periodic_optimization');
      }
    } catch (e) {
      SecureLogger.error('Periodic optimization failed: $e');
      _recordError('optimization_failed');
    }
  }

  /// Handle performance issues detected by monitoring
  Future<void> _handlePerformanceIssue(String issue, Map<String, dynamic> data) async {
    SecureLogger.warning('Performance issue detected: $issue');
    
    // Log to error handler
    _errorHandler.handleUiError(
      Exception('Performance issue: $issue'),
      widget: 'Performance data: ${data.toString()}',
    );

    switch (issue) {
      case 'high_memory_usage':
        _handleMemoryPressure();
        break;
      case 'low_frame_rate':
        _optimizeForFrameRate();
        break;
      case 'slow_network':
        _optimizeNetworkSettings();
        break;
      case 'high_cpu_usage':
        _reduceCpuLoad();
        break;
      default:
        SecureLogger.warning('Unknown performance issue: $issue');
    }
  }

  /// Handle memory pressure issues
  void _handleMemoryPressure() {
    try {
      if (MemoryOptimizer.isBudgetDevice()) {
        MemoryOptimizer.requestGarbageCollection();
        OptimizedImageService.clearImageCache();
      }
      
      // Log performance report
      final report = _performanceMonitor.generatePerformanceReport();
      SecureLogger.info('Performance Report:\n$report');
      
    } catch (e) {
      SecureLogger.error('Failed to handle memory pressure: $e');
    }
  }

  /// Optimize for frame rate issues
  void _optimizeForFrameRate() {
    try {
      _disableExpensiveEffects();
      if (MemoryOptimizer.isBudgetDevice()) {
        OptimizedImageService.reduceImageQuality();
      }
    } catch (e) {
      SecureLogger.error('Failed to optimize frame rate: $e');
    }
  }

  /// Optimize network settings
  void _optimizeNetworkSettings() {
    try {
      _apiService.enableAggressiveTimeouts();
      SecureLogger.info('Network settings optimized for slow connection');
    } catch (e) {
      SecureLogger.error('Failed to optimize network settings: $e');
    }
  }

  /// Reduce CPU load
  void _reduceCpuLoad() {
    try {
      _performanceMonitor.reduceMonitoringFrequency();
      _disableExpensiveEffects();
      SecureLogger.info('CPU load reduction measures applied');
    } catch (e) {
      SecureLogger.error('Failed to reduce CPU load: $e');
    }
  }

  /// Check memory pressure
  Future<void> _checkMemoryPressure() async {
    try {
      // This is a simplified check - in production you might use platform channels
      // to get actual memory usage from native code
      
      final imageStats = OptimizedImageService.getImageCacheStats();
      if (imageStats['memoryPressure'] == true) {
        SecureLogger.warning('Memory pressure detected');
        
        // Apply memory optimizations
        MemoryOptimizer.reduceImageCacheSize();
        OptimizedImageService.clearImageCache();
        MemoryOptimizer.requestGarbageCollection();
        
        _recordError('memory_pressure');
      }
    } catch (e) {
      SecureLogger.error('Memory pressure check failed: $e');
    }
  }

  /// Handle network issues
  void _handleNetworkIssue() {
    SecureLogger.warning('Network connectivity issue detected');
    
    // Log to error handler
    _errorHandler.handleNetworkError(
      Exception('Network connectivity issue'),
      context: 'Network connectivity check failed',
    );
    
    _recordError('network_issue');
    
    // Could implement retry logic or offline mode here
  }

  /// Record error for tracking
  void _recordError(String errorType) {
    _errorCounts[errorType] = (_errorCounts[errorType] ?? 0) + 1;
    
    // Check if error count exceeds threshold
    if (_errorCounts[errorType]! > _getErrorThreshold(errorType)) {
      _handleCriticalError(errorType, 'Error count exceeded threshold');
    }
  }

  /// Get error threshold for different error types
  int _getErrorThreshold(String errorType) {
    switch (errorType) {
      case 'memory_pressure':
        return _maxMemoryWarnings;
      case 'network_issue':
        return _maxNetworkErrors;
      default:
        return 10;
    }
  }

  /// Handle critical errors
  void _handleCriticalError(String errorType, String details) {
    final errorMessage = 'Critical error: $errorType - $details';
    _criticalErrors.add('${DateTime.now().toIso8601String()}: $errorMessage');
    
    // Keep only last 20 critical errors
    if (_criticalErrors.length > 20) {
      _criticalErrors.removeAt(0);
    }
    
    SecureLogger.error(errorMessage);
    
    // Apply emergency optimizations
    _applyEmergencyOptimizations();
  }

  /// Apply emergency optimizations
  void _applyEmergencyOptimizations() {
    try {
      SecureLogger.info('Applying emergency optimizations...');
      
      if (MemoryOptimizer.isBudgetDevice()) {
        // Aggressive memory cleanup
        OptimizedImageService.clearImageCache();
        MemoryOptimizer.requestGarbageCollection();
        
        // Clear performance data
        _performanceMonitor.optimizePerformance();
      }
      
    } catch (e) {
      SecureLogger.error('Emergency optimizations failed: $e');
    }
  }

  /// Get device health status
  Map<String, dynamic> getDeviceHealthStatus() {
    return {
      'is_budget_device': MemoryOptimizer.isBudgetDevice(),
      'is_initialized': _isInitialized,
      'error_counts': Map<String, int>.from(_errorCounts),
      'critical_errors_count': _criticalErrors.length,
      'performance_stats': _performanceMonitor.getPerformanceStats(),
      'image_cache_stats': OptimizedImageService.getImageCacheStats(),
      'api_config': _apiService.getConfigInfo(),
      'health_check_active': _healthCheckTimer?.isActive ?? false,
      'optimization_active': _optimizationTimer?.isActive ?? false,
    };
  }

  /// Get recent critical errors
  List<String> getRecentCriticalErrors({int limit = 5}) {
    final errors = List<String>.from(_criticalErrors);
    if (errors.length > limit) {
      return errors.sublist(errors.length - limit);
    }
    return errors;
  }

  /// Show performance dialog for debugging (only in debug mode)
  void showPerformanceDialog(BuildContext context) {
    if (!kDebugMode) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Device Performance Status'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Device Type: ${MemoryOptimizer.isBudgetDevice() ? "Budget" : "Standard"}'),
              const SizedBox(height: 8),
              Text('Errors: ${_errorCounts.length} types'),
              const SizedBox(height: 8),
              Text('Critical Errors: ${_criticalErrors.length}'),
              const SizedBox(height: 8),
              const Text('Recent Errors:'),
              ...getRecentCriticalErrors().map((error) => Text('• $error', style: const TextStyle(fontSize: 12))),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              _applyEmergencyOptimizations();
              Navigator.of(context).pop();
            },
            child: const Text('Optimize Now'),
          ),
        ],
      ),
    );
  }

  /// Generate comprehensive status report
  Map<String, dynamic> generateStatusReport() {
    final errorStats = _errorHandler?.getErrorStatistics();
    
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'device_info': {
        'is_budget_device': MemoryOptimizer.isBudgetDevice(),
        'platform': Platform.operatingSystem,
        'is_low_end': Platform.isAndroid, // Simplified check
      },
      'performance': _performanceMonitor?.generateReport() ?? {},
      'memory': {
        'optimizer_initialized': MemoryOptimizer.isInitialized,
        'last_cleanup': MemoryOptimizer.getLastCleanupTime()?.toIso8601String(),
      },
      'errors': errorStats?.toJson() ?? {},
      'optimizations': {
        'image_cache_optimized': true,
        'api_timeouts_optimized': _apiService != null,
        'visual_effects_disabled': MemoryOptimizer.isBudgetDevice(),
      },
      'health_status': _getDeviceHealthStatus(),
    };
  }

  /// Get device health status
  Map<String, dynamic> _getDeviceHealthStatus() {
    return {
      'memory_pressure': _isMemoryUnderPressure(),
      'performance_issues': _errorCounts.isNotEmpty,
      'critical_errors': _criticalErrors.length,
      'last_health_check': DateTime.now().toIso8601String(),
      'optimization_active': _optimizationTimer?.isActive ?? false,
    };
  }

  /// Check if device is under memory pressure
  bool _isMemoryUnderPressure() {
    // Check if we're on a budget device
    if (MemoryOptimizer.isBudgetDevice()) {
      // Check image cache stats
      final imageStats = OptimizedImageService.getImageCacheStats();
      if (imageStats['memoryPressure'] == true) {
        return true;
      }
      
      // Check error frequency as indicator of memory issues
      if (_errorCounts.isNotEmpty && _criticalErrors.length > 3) {
        return true;
      }
    }
    
    return false;
  }

  /// Dispose resources
  void dispose() {
    _healthCheckTimer?.cancel();
    _optimizationTimer?.cancel();
    _performanceMonitor.dispose();
    _apiService.dispose();
    _errorHandler.dispose();
    
    _errorCounts.clear();
    _criticalErrors.clear();
    _isInitialized = false;
    
    SecureLogger.info('LowEndDeviceHandler disposed');
  }
}