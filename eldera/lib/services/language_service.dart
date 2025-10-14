import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguage = 'en_US';

  static LanguageService? _instance;
  static LanguageService get instance {
    _instance ??= LanguageService._internal();
    return _instance!;
  }

  LanguageService._internal();

  String _currentLanguage = _defaultLanguage;

  // Available languages
  static const Map<String, String> availableLanguages = {
    'en_US': 'English (US)',
    'fil_PH': 'Filipino',
  };

  String get currentLanguage => _currentLanguage;
  String get currentLanguageDisplayName =>
      availableLanguages[_currentLanguage] ?? 'English (US)';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? _defaultLanguage;
  }

  Future<void> setLanguage(String languageCode) async {
    if (availableLanguages.containsKey(languageCode)) {
      _currentLanguage = languageCode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    }
  }

  bool get isEnglish => _currentLanguage == 'en_US';
  bool get isFilipino => _currentLanguage == 'fil_PH';

  // Text translations
  String getText(String key) {
    final translations = _getTranslations();
    return translations[key] ?? key;
  }

  Map<String, String> _getTranslations() {
    switch (_currentLanguage) {
      case 'fil_PH':
        return _filipinoTranslations;
      case 'en_US':
      default:
        return _englishTranslations;
    }
  }

  /// Translate free-form announcement content heuristically for Filipino.
  /// This targets common English phrases used in `announcement.what` and returns
  /// a localized string when the current language is Filipino. If no mapping is
  /// found, returns the original text.
  String translateFreeText(String text) {
    if (isFilipino) {
      final lower = text.toLowerCase();
      // Simple phrase replacements; keep punctuation and proper nouns intact
      String translated = text;

      // Common lead-in phrases
      translated = translated.replaceAll(
          RegExp(r'^free\s+', caseSensitive: false), 'Libreng ');
      translated = translated.replaceAll(
          RegExp(r'^monthly\s+', caseSensitive: false), 'Buwanang ');
      translated = translated.replaceAll(
          RegExp(r'^weekly\s+', caseSensitive: false), 'Lingguhang ');
      translated = translated.replaceAll(
          RegExp(r'^updated\s+', caseSensitive: false), 'Na-update na ');

      // Common phrases within sentences
      translated = translated.replaceAll(
          RegExp(r'free ', caseSensitive: false), 'libreng ');
      translated = translated.replaceAll(
          RegExp(r'health ', caseSensitive: false), 'kalusugan ');
      translated = translated.replaceAll(
          RegExp(r'check[- ]?up', caseSensitive: false), 'check-up');
      translated = translated.replaceAll(
          RegExp(r'comprehensive ', caseSensitive: false), 'komprehensibong ');
      translated = translated.replaceAll(
          RegExp(r'blood pressure', caseSensitive: false), 'presyon ng dugo');
      translated = translated.replaceAll(
          RegExp(r'blood sugar', caseSensitive: false), 'asukal sa dugo');
      translated = translated.replaceAll(
          RegExp(r'physical examination', caseSensitive: false),
          'pisikal na pagsusuri');
      translated = translated.replaceAll(
          RegExp(r'registered senior citizens', caseSensitive: false),
          'rehistradong nakatatanda');

      translated = translated.replaceAll(
          RegExp(r'pension', caseSensitive: false), 'pensyon');
      translated = translated.replaceAll(
          RegExp(r'qualified', caseSensitive: false), 'kwalipikadong');
      translated = translated.replaceAll(
          RegExp(r'beneficiaries', caseSensitive: false), 'benepisyaryo');
      translated = translated.replaceAll(
          RegExp(r'please bring', caseSensitive: false), 'pakidalang');
      translated = translated.replaceAll(
          RegExp(r'valid id', caseSensitive: false), 'valid ID');
      translated = translated.replaceAll(
          RegExp(r'pension booklet', caseSensitive: false),
          'libretang pensyon');

      translated = translated.replaceAll(
          RegExp(r'exercise program', caseSensitive: false),
          'programang ehersisyo');
      translated = translated.replaceAll(
          RegExp(r'wellness', caseSensitive: false), 'kapakanan');
      translated = translated.replaceAll(
          RegExp(r'designed specifically for senior citizens',
              caseSensitive: false),
          'dinisenyo para sa mga nakatatanda');
      translated = translated.replaceAll(
          RegExp(r'light aerobics', caseSensitive: false),
          'banayad na aerobics');
      translated = translated.replaceAll(
          RegExp(r'stretching', caseSensitive: false), 'pag-uunat');
      translated = translated.replaceAll(
          RegExp(r'health education', caseSensitive: false),
          'edukasyong pangkalusugan');

      translated = translated.replaceAll(
          RegExp(r'emergency contact numbers', caseSensitive: false),
          'mga emergency contact number');
      translated = translated.replaceAll(
          RegExp(r'medical emergencies', caseSensitive: false),
          'medikal na emerhensiya');
      translated = translated.replaceAll(
          RegExp(r'fire incidents', caseSensitive: false),
          'insidente ng sunog');
      translated = translated.replaceAll(
          RegExp(r'police assistance', caseSensitive: false),
          'tulong ng pulis');
      translated = translated.replaceAll(
          RegExp(r'save these numbers', caseSensitive: false),
          'i-save ang mga numerong ito');

      translated = translated.replaceAll(
          RegExp(r'digital literacy training', caseSensitive: false),
          'pagsasanay sa digital literacy');
      translated = translated.replaceAll(
          RegExp(r'learn basic smartphone and internet usage',
              caseSensitive: false),
          'matutong gumamit ng smartphone at internet');
      translated = translated.replaceAll(
          RegExp(r'free training sessions', caseSensitive: false),
          'libreng mga sesyon ng pagsasanay');
      translated = translated.replaceAll(
          RegExp(r'navigate digital services', caseSensitive: false),
          'gumamit ng mga digital na serbisyo');
      translated = translated.replaceAll(
          RegExp(r'stay connected with family', caseSensitive: false),
          'manatiling konektado sa pamilya');

      return translated;
    }
    return text;
  }

  // English translations
  static const Map<String, String> _englishTranslations = {
    // Navigation
    'home': 'HOME',
    'notification': 'NOTIFICATION',
    'schedule': 'SCHEDULE',
    'notifications': 'NOTIFICATIONS',
    'settings': 'SETTINGS',

    // Common actions
    'back': 'BACK',
    'view': 'VIEW',
    'play': 'Play',
    'change': 'Change',
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'save': 'Save',
    'edit': 'Edit',
    'delete': 'Delete',
    'add': 'Add',
    'search': 'Search',
    'filter': 'Filter',
    'refresh': 'Refresh',
    'loading': 'Loading...',
    'close': 'Close',

    // Accessibility quick actions
    'high_contrast': 'High Contrast',
    'increase_font': 'Increase Font',
    'decrease_font': 'Decrease Font',
    'reset_font': 'Reset Font',

    // Settings screen
    'font_size': 'Font Size',
    'tutorial': 'Tutorial',
    'language': 'Language',
    'logout': 'Logout',
    'about': 'About',
    'select_language': 'Select Language',
    'language_changed': 'Language changed successfully',
    'sample_text_preview': 'Font size preview',

    // Profile screen
    'profile': 'Profile',
    'years_old': 'years Old',
    'birth_date': 'Birth Date',
    'address': 'Address',
    'name': 'Name',
    'age': 'Age',
    'phone': 'Phone',
    'email': 'Email',

    // Home screen
    'announcements': 'Announcements',
    'categories': 'Categories',
    'all': 'ALL',
    'pension': 'PENSION',
    'health': 'HEALTH',
    'general': 'GENERAL',
    'benefits': 'BENEFITS',
    'dswd_pension': 'DSWD Pension',
    'read_more': 'Read More',
    'no_announcements': 'No announcements available',
    'error_loading': 'Error loading data',

    // Schedule screen
    'calendar': 'Calendar',
    'today': 'Today',
    'events': 'Events',
    'no_events': 'No events for this date',
    'current_date': 'CURRENT DATE',
    'upcoming': 'Upcoming',
    'past': 'Past',
    'ongoing': 'Ongoing',
    'completed': 'Completed',
    'status': 'STATUS',

    // Attendance
    'attendance': 'Attendance',
    'attendance_summary': 'Attendance Summary',
    'attended': 'Attended',
    'missed': 'Missed',
    'total': 'Total',
    'filter_by': 'Filter by:',
    'no_attendance_records': 'No attendance records found',

    // Notifications screen
    'mark_as_read': 'Mark as Read',
    'mark_all_read': 'Mark All as Read',
    'no_notifications': 'No notifications',
    'new_notification': 'New Notification',
    'new': 'NEW',

    // Time and date
    'morning': 'Morning',
    'afternoon': 'Afternoon',
    'evening': 'Evening',
    'night': 'Night',
    'today_date': 'Today',
    'yesterday': 'Yesterday',
    'tomorrow': 'Tomorrow',
    // Time ago
    'days_ago': '%d days ago',
    'hours_ago': '%d hours ago',
    'minutes_ago': '%d minutes ago',
    'just_now': 'Just now',
    // Relative time
    'in_days': 'in %d days',
    'in_hours': 'in %d hours',
    'in_minutes': 'in %d minutes',
    'now': 'now',

    // Common phrases
    'welcome': 'Welcome',
    'good_morning': 'Good Morning',
    'good_afternoon': 'Good Afternoon',
    'good_evening': 'Good Evening',
    'thank_you': 'Thank You',
    'please_wait': 'Please wait...',
    'try_again': 'Try Again',
    'error_occurred': 'An error occurred',
    'success': 'Success',
    'failed': 'Failed',
    'reminder_set': 'Reminder Set',
    'remind_me': 'Remind Me',
    'select_image_source': 'Select Image Source',
    'gallery': 'Gallery',
    'camera': 'Camera',
    'guardian': 'Guardian:',
    'id_status': 'ID Status',
    // Detail labels
    'what': 'WHAT',
    'when': 'WHEN',
    'where': 'WHERE',
    'category': 'Category',
    'reminder': 'Reminder',

    // Reminder dialog
    'set_reminder': 'Set Reminder',
    'one_hour_before': '1 hour before',
    'one_day_before': '1 day before',
    'custom_time': 'Custom time',
    'reminder_failed_try_again': 'Failed to set reminder. Please try again.',
    'reminder_invalid_time':
        'Failed to set reminder. Please select a time before the event.',
    'no_reminder': 'No reminder',
    'added_to_calendar': 'and added to calendar',
    'reminder_removed': 'Reminder removed',
    'removed_from_calendar': 'and removed from calendar',
  };

  // Filipino translations
  static const Map<String, String> _filipinoTranslations = {
    // Navigation
    'home': 'TAHANAN',
    'notification': 'ABISO',
    'schedule': 'ISKEDYUL',
    'notifications': 'MGA ABISO',
    'settings': 'MGA SETTING',

    // Common actions
    'back': 'BALIK',
    'view': 'TINGNAN',
    'play': 'I-play',
    'change': 'Baguhin',
    'cancel': 'Kanselahin',
    'confirm': 'Kumpirmahin',
    'save': 'I-save',
    'edit': 'I-edit',
    'delete': 'Tanggalin',
    'add': 'Idagdag',
    'search': 'Maghanap',
    'filter': 'I-filter',
    'refresh': 'I-refresh',
    'loading': 'Naglo-load...',
    'close': 'Isara',

    // Accessibility quick actions
    'high_contrast': 'Mataas na Kontrast',
    'increase_font': 'Palakihin ang Font',
    'decrease_font': 'Paliitin ang Font',
    'reset_font': 'I-reset ang Font',

    // Settings screen
    'font_size': 'Laki ng Font',
    'tutorial': 'Tutorial',
    'language': 'Wika',
    'logout': 'Mag-logout',
    'about': 'Tungkol',
    'select_language': 'Pumili ng Wika',
    'language_changed': 'Matagumpay na nabago ang wika',
    'sample_text_preview': 'Laki ng font',

    // Profile screen
    'profile': 'Profile',
    'years_old': 'taong gulang',
    'birth_date': 'Petsa ng Kapanganakan',
    'address': 'Address',
    'name': 'Pangalan',
    'age': 'Edad',
    'phone': 'Telepono',
    'email': 'Email',

    // Home screen
    'announcements': 'Mga Pabatid',
    'categories': 'Mga Kategorya',
    'all': 'LAHAT',
    'pension': 'PENSYON',
    'health': 'KALUSUGAN',
    'general': 'PANGKALAHATAN',
    'benefits': 'MGA BENEPISYO',
    'dswd_pension': 'DSWD Pension',
    'read_more': 'Basahin pa',
    'no_announcements': 'Walang mga pabatid',
    'error_loading': 'May error sa pag-load ng data',

    // Schedule screen
    'calendar': 'Kalendaryo',
    'today': 'Ngayon',
    'events': 'Mga Kaganapan',
    'no_events': 'Walang kaganapan sa petsang ito',
    'current_date': 'KASALUKUYANG PETSA',
    'upcoming': 'Paparating',
    'past': 'Nakaraan',
    'ongoing': 'Kasalukuyan',
    'completed': 'Tapos na',
    'status': 'KALAGAYAN',

    // Attendance
    'attendance': 'Pagdalo',
    'attendance_summary': 'Buod ng Pagdalo',
    'attended': 'Dumalo',
    'missed': 'Hindi Dumalo',
    'total': 'Kabuuan',
    'filter_by': 'I-filter ayon sa:',
    'no_attendance_records': 'Walang nakitang record ng pagdalo',

    // Notifications screen
    'mark_as_read': 'Markahan bilang Nabasa',
    'mark_all_read': 'Markahan Lahat bilang Nabasa',
    'no_notifications': 'Walang mga abiso',
    'new_notification': 'Bagong Abiso',
    'new': 'BAGO',

    // Time and date
    'morning': 'Umaga',
    'afternoon': 'Hapon',
    'evening': 'Gabi',
    'night': 'Gabi',
    'today_date': 'Ngayon',
    'yesterday': 'Kahapon',
    'tomorrow': 'Bukas',
    // Time ago
    'days_ago': '%d araw na ang nakalipas',
    'hours_ago': '%d oras na ang nakalipas',
    'minutes_ago': '%d minuto na ang nakalipas',
    'just_now': 'Ngayon lang',
    // Relative time
    'in_days': 'sa %d araw',
    'in_hours': 'sa %d oras',
    'in_minutes': 'sa %d minuto',
    'now': 'ngayon',

    // Common phrases
    'welcome': 'Maligayang pagdating',
    'good_morning': 'Magandang Umaga',
    'good_afternoon': 'Magandang Hapon',
    'good_evening': 'Magandang Gabi',
    'thank_you': 'Salamat',
    'please_wait': 'Pakihintay...',
    'try_again': 'Subukan Muli',
    'error_occurred': 'May naganap na error',
    'success': 'Tagumpay',
    'failed': 'Nabigo',
    'reminder_set': 'Naka-set na ang Reminder',
    'remind_me': 'Paalalahanan Mo Ako',
    'select_image_source': 'Pumili ng Source ng Larawan',
    'gallery': 'Gallery',
    'camera': 'Camera',
    'guardian': 'Guardian:',
    'id_status': 'Status ng ID',
    // Detail labels
    'what': 'ANO',
    'when': 'KAILAN',
    'where': 'SAAN',
    'category': 'Kategorya',
    'reminder': 'Paalala',

    // Reminder dialog
    'set_reminder': 'Magtakda ng Paalala',
    'one_hour_before': '1 oras bago',
    'one_day_before': '1 araw bago',
    'custom_time': 'Pasadyang oras',
    'reminder_failed_try_again':
        'Nabigo ang pag-set ng paalala. Pakisubukang muli.',
    'reminder_invalid_time':
        'Nabigo ang pag-set ng paalala. Pumili ng oras bago ang kaganapan.',
    'no_reminder': 'Walang paalala',
    'added_to_calendar': 'at naidagdag sa kalendaryo',
    'reminder_removed': 'Natanggal ang paalala',
    'removed_from_calendar': 'at natanggal sa kalendaryo',
  };
}
