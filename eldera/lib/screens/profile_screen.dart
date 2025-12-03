import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../services/font_size_service.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import '../services/secure_storage_service.dart';
import '../services/language_service.dart';
import '../models/user.dart' as app_user;
import 'admin_simulation_screen.dart';
import 'login_screen.dart';
import '../config/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FontSizeService _fontSizeService = FontSizeService.instance;
  final LanguageService _languageService = LanguageService.instance;
  // Using UserService and AuthService
  Uint8List? _selectedImage; // Use Uint8List for both web and mobile
  app_user.User? _currentUser;
  String? _authToken;

  Future<void> _loadProfileImageFromApi() async {
    final url = _currentUser?.profileImageUrl;
    if (url == null || url.isEmpty) return;
    final token = _authToken ?? await SecureStorageService.getAuthToken();
    if (token == null) return;
    try {
      final resp = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'image/*',
        },
      );
      if (resp.statusCode == 200) {
        setState(() {
          _selectedImage = resp.bodyBytes;
        });
      }
    } catch (_) {}
  }

  Future<void> _loadAuthToken() async {
    try {
      final token = await SecureStorageService.getAuthToken();
      setState(() {
        _authToken = token;
      });
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    try {
      await _fontSizeService.init();
      await _languageService.init();

      // Get current user via AuthService (uses IMS token and /senior/profile)
      print('ProfileScreen: Attempting to fetch user data...');
      _currentUser = await AuthService.getCurrentUser();
      if (_currentUser == null ||
          _currentUser!.age == 0 ||
          (_currentUser!.address == null || _currentUser!.address!.isEmpty)) {
        final fallbackUser = await UserService.getCurrentUser();
        if (fallbackUser != null) {
          _currentUser = fallbackUser;
        }
      }

      if (_currentUser != null) {
        print(
            'ProfileScreen: User data loaded successfully: ${_currentUser!.name}');
      } else {
        print('ProfileScreen: No user data returned from AuthService');
        // Show error message to user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Unable to load profile data. Please try logging in again.'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () => _initializeUserData(),
              ),
            ),
          );
        }
      }

      setState(() {});
      await _loadAuthToken();
      await _loadProfileImageFromApi();
    } catch (e) {
      print('ProfileScreen: Error initializing user data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading profile: ${e.toString()}'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _initializeUserData(),
            ),
          ),
        );
      }
    }
  }

  String _getSafeText(String key) {
    try {
      return _languageService.getText(key);
    } catch (e) {
      return key.toUpperCase();
    }
  }

  String _formatBirthDate(String? birthDate) {
    if (birthDate == null || birthDate.isEmpty) return 'Not specified';

    try {
      // Try to parse the date string
      DateTime date = DateTime.parse(birthDate);
      // Format as "Month DD, YYYY" (e.g., "January 15, 1950")
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      // If parsing fails, return the original string
      return birthDate;
    }
  }

  double _getSafeScaledFontSize({
    double? baseSize,
    bool isTitle = false,
    bool isSubtitle = false,
  }) {
    // Check if FontSizeService is properly initialized
    if (!_fontSizeService.isInitialized) {
      // Return default font size if service not initialized
      double defaultSize = 20.0;
      double scaleFactor = baseSize ?? 1.0;

      if (isTitle) {
        scaleFactor = 1.2;
      } else if (isSubtitle) {
        scaleFactor = 1.1;
      }

      return defaultSize * scaleFactor;
    }

    return _fontSizeService.getScaledFontSize(
      baseSize: baseSize ?? 1.0,
      isTitle: isTitle,
      isSubtitle: isSubtitle,
    );
  }

  double _getSafeScaledIconSize({
    double baseSize = 24.0,
    double scaleFactor = 1.0,
  }) {
    // Check if FontSizeService is properly initialized
    if (!_fontSizeService.isInitialized) {
      // Return default icon size if service not initialized
      return baseSize * scaleFactor;
    }

    // Scale icon size based on font size
    // Use a ratio of icon size to font size (24px icon for 20px font = 1.2 ratio)
    double fontSizeRatio =
        _fontSizeService.fontSize / _fontSizeService.defaultFontSize;
    return baseSize * fontSizeRatio * scaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006662),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006662),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _getSafeText('back'),
          style: TextStyle(
            color: Colors.white,
            fontSize: _getSafeScaledFontSize(isSubtitle: true),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.memory(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            )
                          : (_currentUser?.profileImageUrl != null
                              ? Image.network(
                                  _currentUser!.profileImageUrl!,
                                  headers: _authToken != null
                                      ? {'Authorization': 'Bearer $_authToken'}
                                      : null,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (context, error, stack) {
                                    return Container(
                                      color: const Color(0xFF2D5A5A),
                                    );
                                  },
                                )
                              : Container(
                                  color: const Color(0xFF2D5A5A),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFE8B4A0),
                                        ),
                                      ),
                                      Positioned(
                                        top: 15,
                                        child: Container(
                                          width: 70,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFD3D3D3),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(35),
                                              topRight: Radius.circular(35),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        child: Container(
                                          width: 30,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: 80,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF4CAF50),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // User Name
                  Text(
                    _currentUser?.name ?? 'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _getSafeScaledFontSize(isTitle: true),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Age
                  Text(
                    (_currentUser != null && _currentUser!.age > 0)
                        ? '${_currentUser!.age} ${_getSafeText('years_old')}'
                        : 'Not specified',
                    style: TextStyle(
                      color: AppColors.textSecondaryOnPrimary,
                      fontSize: _getSafeScaledFontSize(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Birth Date
                  Text(
                    _formatBirthDate(_currentUser?.birthDate),
                    style: TextStyle(
                      color: AppColors.textSecondaryOnPrimary,
                      fontSize: _getSafeScaledFontSize(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Address
                  Text(
                    _currentUser?.address ?? _getSafeText('loading'),
                    style: TextStyle(
                      color: AppColors.textSecondaryOnPrimary,
                      fontSize: _getSafeScaledFontSize(baseSize: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
