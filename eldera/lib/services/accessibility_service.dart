import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'font_size_service.dart';

/// AccessibilityService centralizes high-contrast mode and text scaling.
/// It persists settings via SharedPreferences and notifies listeners on change
/// so that the app can rebuild themes accordingly.
class AccessibilityService extends ChangeNotifier {
  static const String _highContrastKey = 'high_contrast_enabled';

  static AccessibilityService? _instance;
  static AccessibilityService get instance {
    _instance ??= AccessibilityService._internal();
    return _instance!;
  }

  AccessibilityService._internal();

  SharedPreferences? _prefs;
  bool _highContrastEnabled = false;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _highContrastEnabled = _prefs!.getBool(_highContrastKey) ?? false;
  }

  bool get isInitialized => _prefs != null;

  bool get isHighContrast => _highContrastEnabled;

  Future<void> setHighContrast(bool enabled) async {
    if (_prefs == null) await init();
    _highContrastEnabled = enabled;
    await _prefs!.setBool(_highContrastKey, enabled);
    notifyListeners();
  }

  Future<void> toggleHighContrast() async {
    await setHighContrast(!isHighContrast);
  }

  /// Convenience wrappers around FontSizeService for common actions
  final FontSizeService _fontSizeService = FontSizeService.instance;

  double get currentFontSize => _fontSizeService.fontSize;

  Future<void> increaseFontSize([double step = 2.0]) async {
    await _fontSizeService.setFontSize(_fontSizeService.fontSize + step);
    notifyListeners();
  }

  Future<void> decreaseFontSize([double step = 2.0]) async {
    await _fontSizeService.setFontSize(_fontSizeService.fontSize - step);
    notifyListeners();
  }

  Future<void> resetFontSize() async {
    await _fontSizeService.setFontSize(_fontSizeService.defaultFontSize);
    notifyListeners();
  }

  double getScaledFontSize({
    double baseSize = 1.0,
    bool isTitle = false,
    bool isSubtitle = false,
    bool isCaption = false,
  }) {
    return _fontSizeService.getScaledFontSize(
      baseSize: baseSize,
      isTitle: isTitle,
      isSubtitle: isSubtitle,
      isCaption: isCaption,
    );
  }
}