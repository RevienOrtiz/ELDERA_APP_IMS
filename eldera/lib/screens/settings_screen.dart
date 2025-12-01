import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/secure_storage_service.dart';
import '../services/font_size_service.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../services/language_service.dart';
import '../config/environment_config.dart';
import '../models/user.dart' as app_user;
import 'profile_screen.dart';
import 'login_screen.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FontSizeService _fontSizeService = FontSizeService.instance;
  final LanguageService _languageService = LanguageService.instance;
  // Using SupabaseAuthService instead of AuthService
  // Using SupabaseUserService instead of UserService
  double _currentFontSize = 20.0;
  Uint8List? _selectedImage;
  app_user.User? _currentUser;
  bool _geminiTtsConfigured = false;
  String? _authToken;
  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileImage();
  }

  Future<void> _initializeData() async {
    await _loadFontSize();
    await _languageService.init();
    await _loadUserData();
    await _loadAuthToken();
    await _loadProfileImage();
    await _loadGeminiTtsPrefs();
  }

  Future<void> _loadFontSize() async {
    await _fontSizeService.init();
    setState(() {
      _currentFontSize = _fontSizeService.fontSize;
    });
  }

  Future<void> _loadUserData() async {
    try {
      _currentUser = await AuthService.getCurrentUser();
      if (_currentUser == null) {
        _currentUser = await UserService.getCurrentUser();
      }

      if (_currentUser == null) {
        // Show error message if user data couldn't be loaded
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unable to load user profile. Please try again.'),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () => _loadUserData(),
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Show error message for any exceptions
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load user profile: ${e.toString()}'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _loadUserData(),
            ),
          ),
        );
      }
    }

    setState(() {});
  }

  Future<void> _loadAuthToken() async {
    try {
      final token = await SecureStorageService.getAuthToken();
      setState(() {
        _authToken = token;
      });
    } catch (_) {}
  }

  Future<void> _loadProfileImage() async {
    try {
      if (kIsWeb) {
        final url = _currentUser?.profileImageUrl;
        if (url == null || url.isEmpty) return;
        final token = _authToken ?? await SecureStorageService.getAuthToken();
        if (token == null) return;
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
      } else {
        final prefs = await SharedPreferences.getInstance();
        final bytes = prefs.getString('profile_image');
        if (bytes != null) {
          setState(() {
            _selectedImage = Uint8List.fromList(const []);
          });
        }
      }
    } catch (_) {}
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

  String _getSafeText(String key) {
    try {
      return _languageService.getText(key);
    } catch (e) {
      // Return the key itself as fallback if language service fails
      return key.toUpperCase();
    }
  }

  String _getSafeLanguageDisplayName() {
    try {
      return _languageService.currentLanguageDisplayName;
    } catch (e) {
      // Return default language name if service fails
      return 'English (US)';
    }
  }

  Future<void> _loadGeminiTtsPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final envKey = await EnvironmentConfig.geminiApiKey;
      final apiKey = envKey ?? prefs.getString('gemini_api_key');
      setState(() {
        _geminiTtsConfigured = (apiKey != null && apiKey.isNotEmpty);
      });
    } catch (_) {}
  }

  String _getSafeCurrentLanguage() {
    try {
      return _languageService.currentLanguage;
    } catch (e) {
      // Return default language if service fails
      return 'en_US';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFFFFFF0), // Ivory white background for better accessibility
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E8B8B),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          _getSafeText('settings'),
          style: TextStyle(
            color: Colors.white,
            fontSize: _getSafeScaledFontSize(isTitle: true),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Profile Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: ClipOval(
                    child: _selectedImage != null
                        ? Image.memory(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          )
                        : (_currentUser?.profileImageUrl != null
                            ? Image.network(
                                _currentUser!.profileImageUrl!,
                                headers: _authToken != null
                                    ? {'Authorization': 'Bearer $_authToken'}
                                    : null,
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              )
                            : Container(
                                color: const Color(0xFF2D5A5A),
                              )),
                  ),
                ),
                const SizedBox(width: 16),
                // Profile Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentUser?.name ?? 'Loading...',
                        style: TextStyle(
                          fontSize: _getSafeScaledFontSize(isTitle: true),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                // VIEW Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E8B8B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getSafeText('view'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Settings Options
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2.25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildFontSizeItem(),
                    const SizedBox(height: 12),
                    _buildSettingItem(
                      _getSafeText('tutorial'),
                      Icons.play_arrow,
                      _getSafeText('play'),
                      const Color(0xFF00BFFF),
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageItem(),
                    const SizedBox(height: 12),
                    _buildChangePasswordEntryItem(),
                    const SizedBox(height: 12),
                    _buildLogoutItem(),
                    const SizedBox(height: 16), // Extra padding at bottom
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.text_fields,
                  color: const Color(0xFF2E8B8B),
                  size: _getSafeScaledIconSize(),
                ),
              ),
              const SizedBox(width: 16),
              // Title
              Expanded(
                child: Text(
                  _getSafeText('font_size'),
                  style: TextStyle(
                    fontSize: _currentFontSize *
                        0.8, // Responsive to current font size
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Current size display
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_currentFontSize.round()}px',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Font size slider
          Row(
            children: [
              Text(
                '${_fontSizeService.minFontSize.round()}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Expanded(
                child: Slider(
                  value: _currentFontSize,
                  min: _fontSizeService.minFontSize,
                  max: _fontSizeService.maxFontSize,
                  divisions: (_fontSizeService.maxFontSize -
                          _fontSizeService.minFontSize)
                      .round(),
                  activeColor: const Color(0xFF00BFFF),
                  inactiveColor: Colors.grey.shade300,
                  onChanged: (value) async {
                    setState(() {
                      _currentFontSize = value;
                    });
                    await _fontSizeService.setFontSize(value);
                  },
                  onChangeEnd: (value) async {
                    await _fontSizeService.setFontSize(value);
                  },
                ),
              ),
              Text(
                '${_fontSizeService.maxFontSize.round()}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          // Preview text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              'Font size preview',
              style: TextStyle(
                fontSize: _currentFontSize,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    String title,
    IconData icon,
    String buttonText,
    Color buttonColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2E8B8B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: _getSafeScaledFontSize(isSubtitle: true),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.language,
              color: const Color(0xFF2E8B8B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Title and Current Language
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getSafeText('language'),
                  style: TextStyle(
                    fontSize: _getSafeScaledFontSize(isSubtitle: true),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  _getSafeLanguageDisplayName(),
                  style: TextStyle(
                    fontSize: _getSafeScaledFontSize(baseSize: 0.8),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Change Button
          GestureDetector(
            onTap: _showLanguageSelectionDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getSafeText('change'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangePasswordEntryItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.lock,
              color: const Color(0xFF2E8B8B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _getSafeText('change_password'),
              style: TextStyle(
                fontSize: _getSafeScaledFontSize(isSubtitle: true),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          GestureDetector(
            onTap: _openChangePasswordScreen,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getSafeText('change'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Removed secondary duplicate stub

  Future<void> _handleChangePassword() async {
    final form = _changePasswordFormKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    setState(() {
      _isChangingPassword = true;
    });

    final result = await AuthService.changePassword(
      currentPassword: _currentPasswordController.text.trim(),
      newPassword: _newPasswordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );

    setState(() {
      _isChangingPassword = false;
    });

    if (!mounted) return;

    final success = result['success'] == true;
    final message = result['message']?.toString() ??
        (success
            ? _getSafeText('password_changed')
            : _getSafeText('password_change_failed'));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    if (success) {
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            _getSafeText('select_language'),
            style: TextStyle(
              fontSize: _getSafeScaledFontSize(isTitle: true),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: LanguageService.availableLanguages.entries.map((entry) {
              final languageCode = entry.key;
              final languageName = entry.value;
              final isSelected = _getSafeCurrentLanguage() == languageCode;

              return ListTile(
                title: Text(
                  languageName,
                  style: TextStyle(
                    fontSize: _getSafeScaledFontSize(),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                leading: Radio<String>(
                  value: languageCode,
                  groupValue: _getSafeCurrentLanguage(),
                  onChanged: (String? value) {
                    if (value != null) {
                      _changeLanguage(value);
                      Navigator.of(context).pop();
                    }
                  },
                  activeColor: const Color(0xFF2E8B8B),
                ),
                onTap: () {
                  _changeLanguage(languageCode);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                _getSafeText('cancel'),
                style: TextStyle(
                  fontSize: _getSafeScaledFontSize(),
                  color: const Color(0xFF2E8B8B),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openChangePasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen(),
      ),
    );
  }

  Future<void> _changeLanguage(String languageCode) async {
    await _languageService.setLanguage(languageCode);
    setState(() {});

    // Show confirmation message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _getSafeText('language_changed'),
            style: TextStyle(
              fontSize: _getSafeScaledFontSize(),
            ),
          ),
          backgroundColor: const Color(0xFF2E8B8B),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _saveGeminiTtsSettings() async {}

  // Deprecated: kept for compatibility but unused
  Widget _buildChangePasswordItem() {
    return const SizedBox.shrink();
  }

  Widget _buildGeminiTtsItem() {
    return const SizedBox.shrink();
  }

  Widget _buildLogoutItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.logout,
              color: Colors.grey.shade600,
              size: _getSafeScaledIconSize(),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              _getSafeText('logout'),
              style: TextStyle(
                fontSize: _getSafeScaledFontSize(isSubtitle: true),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Logout Button
          GestureDetector(
            onTap: () async {
              await AuthService.signOut();
              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getSafeText('logout'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getSafeScaledFontSize(baseSize: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
