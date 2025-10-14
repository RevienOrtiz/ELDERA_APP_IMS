import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_screen.dart';
import 'main_screen.dart';
import '../services/service_manager.dart';
import '../services/secure_storage_service.dart';
import '../services/auth_service.dart';
import '../services/optimized_image_service.dart';
import '../utils/memory_optimizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;

  bool _servicesInitialized = false;
  String _currentStatus = 'Initializing...';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward();
    _startInitialization();
  }

  void _startInitialization() async {
    final serviceManager = ServiceManager();

    // Listen to real service initialization progress
    serviceManager.addProgressCallback((progress, step) {
      if (mounted) {
        _updateProgress(step, progress);
      }
    });

    // Wait for services to initialize (they're already running in background)
    // Very aggressive timeout to prevent loading delays
    try {
      await serviceManager.waitForService('all',
          timeout: const Duration(seconds: 2)); // Reduced from 5 to 2 seconds
    } catch (e) {
      debugPrint('Service initialization timeout, proceeding anyway: $e');
    }

    // Minimal delay to show completion
    await Future.delayed(
        const Duration(milliseconds: 200)); // Reduced from 500ms

    if (mounted) {
      // Check for stored authentication token to enable persistent login
      final isAuthenticated = await AuthService.isAuthenticatedAsync();

      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  /// Fast token check without network calls
  Future<bool> _hasValidStoredToken() async {
    try {
      final token = await SecureStorageService.getAuthToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking stored token: $e');
      return false;
    }
  }

  Future<void> _updateProgress(String status, double progress) async {
    if (mounted) {
      setState(() {
        _currentStatus = status;
        _progress = progress;
      });

      _progressController.animateTo(progress);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2d7d7d), // Eldera teal color
              Color(0xFF1e5a5a), // Darker teal
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo and App Name
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App Icon/Logo with enhanced styling
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 25,
                                offset: const Offset(0, 15),
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: FutureBuilder<Widget>(
                              future: OptimizedImageService.loadLogo(
                                size: 110,
                                isLowMemoryMode: MemoryOptimizer.isBudgetDevice(),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Icon(
                                    Icons.error,
                                    size: 110,
                                    color: Colors.grey,
                                  );
                                } else {
                                  return snapshot.data ?? const Icon(
                                    Icons.image,
                                    size: 110,
                                    color: Colors.grey,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // App Name
                        const Text(
                          'ELDERA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Enhanced Loading Section
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Enhanced Progress Bar
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _progressAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.white, Color(0xFFe0f2f1)],
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Enhanced Status Text
                        Text(
                          _currentStatus,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
