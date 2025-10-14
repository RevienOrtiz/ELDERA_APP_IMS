import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'config/app_theme.dart';
import 'services/accessibility_service.dart';
import 'services/performance_monitor.dart';
import 'services/optimized_image_service.dart';
import 'services/error_handler_service.dart';
import 'utils/memory_optimizer.dart';
import 'utils/low_end_device_handler.dart';

class ElderaApp extends StatefulWidget {
  const ElderaApp({super.key});

  @override
  State<ElderaApp> createState() => _ElderaAppState();
}

class _ElderaAppState extends State<ElderaApp> {
  final AccessibilityService _accessibility = AccessibilityService.instance;
  PerformanceMonitor? _performanceMonitor;
  LowEndDeviceHandler? _lowEndDeviceHandler;

  @override
  void initState() {
    super.initState();
    _initializeOptimizations();
    // Listen for accessibility changes to rebuild theme dynamically
    _accessibility.addListener(_onAccessibilityChanged);
  }

  /// Initialize performance optimizations for low-end devices
  Future<void> _initializeOptimizations() async {
    try {
      // Initialize low-end device handler which manages all optimizations
      _lowEndDeviceHandler = LowEndDeviceHandler();
      await _lowEndDeviceHandler!.initialize();
      
      // Start performance monitoring
      _performanceMonitor = PerformanceMonitor();
      _performanceMonitor!.initialize();
      
      print('Performance optimizations initialized successfully');
    } catch (e) {
      print('Error initializing optimizations: $e');
    }
  }

  @override
  void dispose() {
    _accessibility.removeListener(_onAccessibilityChanged);
    _performanceMonitor?.dispose();
    _lowEndDeviceHandler?.dispose();
    super.dispose();
  }

  void _onAccessibilityChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool useHighContrast = _accessibility.isHighContrast;

    return MaterialApp(
      title: 'ELDERA',
      theme: useHighContrast ? AppTheme.highContrastTheme : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
