import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'dart:io';

/// Local Database Service for Offline Data Storage
///
/// Provides local SQLite database and Hive cache storage for:
/// - User authentication data persistence
/// - Offline data caching
/// - App settings and preferences
/// - Notification data storage
class LocalDatabaseService {
  static Database? _database;
  static Box? _cacheBox;
  static Box? _authBox;
  static Box? _settingsBox;

  static const String _databaseName = 'eldera_local.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String _tableUsers = 'users';
  static const String _tableNotifications = 'notifications';
  static const String _tableReminders = 'reminders';
  static const String _tableEvents = 'events';
  static const String _tableAnnouncements = 'announcements';

  /// Initialize local database and Hive storage
  static Future<void> initialize() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();

      // Open Hive boxes
      _cacheBox = await Hive.openBox('cache');
      _authBox = await Hive.openBox('auth');
      _settingsBox = await Hive.openBox('settings');

      // Initialize SQLite database
      await _initializeDatabase();

      print('✅ Local database service initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize local database service: $e');
      throw Exception('Local database initialization failed: $e');
    }
  }

  /// Initialize SQLite database
  static Future<void> _initializeDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  /// Create database tables
  static Future<void> _createDatabase(Database db, int version) async {
    // Users table for offline user data
    await db.execute('''
      CREATE TABLE $_tableUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT UNIQUE NOT NULL,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        profile_data TEXT,
        last_sync DATETIME DEFAULT CURRENT_TIMESTAMP,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Notifications table for offline notification storage
    await db.execute('''
      CREATE TABLE $_tableNotifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        notification_id TEXT UNIQUE,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        type TEXT,
        data TEXT,
        is_read INTEGER DEFAULT 0,
        scheduled_time DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Reminders table for scheduled reminders
    await db.execute('''
      CREATE TABLE $_tableReminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        reminder_id TEXT UNIQUE,
        title TEXT NOT NULL,
        description TEXT,
        reminder_time DATETIME NOT NULL,
        is_completed INTEGER DEFAULT 0,
        event_id TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Events table for offline event data
    await db.execute('''
      CREATE TABLE $_tableEvents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_id TEXT UNIQUE,
        title TEXT NOT NULL,
        description TEXT,
        event_date DATETIME,
        location TEXT,
        is_registered INTEGER DEFAULT 0,
        last_sync DATETIME DEFAULT CURRENT_TIMESTAMP,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Announcements table for offline announcements
    await db.execute('''
      CREATE TABLE $_tableAnnouncements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        announcement_id TEXT UNIQUE,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        category TEXT,
        priority TEXT,
        published_date DATETIME,
        is_read INTEGER DEFAULT 0,
        last_sync DATETIME DEFAULT CURRENT_TIMESTAMP,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    print('✅ Database tables created successfully');
  }

  /// Upgrade database schema
  static Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    // Handle database schema upgrades here
    print('📈 Database upgraded from version $oldVersion to $newVersion');
  }

  /// Store authentication data in Hive
  static Future<void> storeAuthData(String key, dynamic value) async {
    try {
      await _authBox?.put(key, value);
      print('✅ Auth data stored: $key');
    } catch (e) {
      print('❌ Failed to store auth data: $e');
    }
  }

  /// Retrieve authentication data from Hive
  static dynamic getAuthData(String key) {
    try {
      return _authBox?.get(key);
    } catch (e) {
      print('❌ Failed to retrieve auth data: $e');
      return null;
    }
  }

  /// Clear all authentication data
  static Future<void> clearAuthData() async {
    try {
      await _authBox?.clear();
      print('✅ Auth data cleared');
    } catch (e) {
      print('❌ Failed to clear auth data: $e');
    }
  }

  /// Store user data locally
  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    try {
      await _database?.insert(
        _tableUsers,
        {
          'user_id': userData['id']?.toString(),
          'email': userData['email'],
          'name': userData['name'],
          'profile_data': jsonEncode(userData),
          'last_sync': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('✅ User data stored locally');
    } catch (e) {
      print('❌ Failed to store user data: $e');
    }
  }

  /// Retrieve user data from local storage
  static Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final List<Map<String, dynamic>> result = await _database?.query(
            _tableUsers,
            where: 'user_id = ?',
            whereArgs: [userId],
            limit: 1,
          ) ??
          [];

      if (result.isNotEmpty) {
        final userData = result.first;
        return jsonDecode(userData['profile_data']);
      }
      return null;
    } catch (e) {
      print('❌ Failed to retrieve user data: $e');
      return null;
    }
  }

  /// Store notification locally
  static Future<void> storeNotification(
      Map<String, dynamic> notification) async {
    try {
      await _database?.insert(
        _tableNotifications,
        {
          'notification_id': notification['id']?.toString(),
          'title': notification['title'],
          'body': notification['body'],
          'type': notification['type'],
          'data': jsonEncode(notification['data'] ?? {}),
          'scheduled_time': notification['scheduled_time'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('✅ Notification stored locally');
    } catch (e) {
      print('❌ Failed to store notification: $e');
    }
  }

  /// Get all notifications
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      final List<Map<String, dynamic>> result = await _database?.query(
            _tableNotifications,
            orderBy: 'created_at DESC',
          ) ??
          [];
      return result;
    } catch (e) {
      print('❌ Failed to retrieve notifications: $e');
      return [];
    }
  }

  /// Store reminder locally
  static Future<void> storeReminder(Map<String, dynamic> reminder) async {
    try {
      await _database?.insert(
        _tableReminders,
        {
          'reminder_id': reminder['id']?.toString(),
          'title': reminder['title'],
          'description': reminder['description'],
          'reminder_time': reminder['reminder_time'],
          'event_id': reminder['event_id']?.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('✅ Reminder stored locally');
    } catch (e) {
      print('❌ Failed to store reminder: $e');
    }
  }

  /// Get upcoming reminders
  static Future<List<Map<String, dynamic>>> getUpcomingReminders() async {
    try {
      final now = DateTime.now().toIso8601String();
      final List<Map<String, dynamic>> result = await _database?.query(
            _tableReminders,
            where: 'reminder_time > ? AND is_completed = 0',
            whereArgs: [now],
            orderBy: 'reminder_time ASC',
          ) ??
          [];
      return result;
    } catch (e) {
      print('❌ Failed to retrieve reminders: $e');
      return [];
    }
  }

  /// Cache data in Hive
  static Future<void> cacheData(String key, dynamic data,
      {Duration? expiry}) async {
    try {
      final cacheEntry = {
        'data': data,
        'cached_at': DateTime.now().millisecondsSinceEpoch,
        'expires_at': expiry != null
            ? DateTime.now().add(expiry).millisecondsSinceEpoch
            : null,
      };
      await _cacheBox?.put(key, cacheEntry);
      print('✅ Data cached: $key');
    } catch (e) {
      print('❌ Failed to cache data: $e');
    }
  }

  /// Retrieve cached data from Hive
  static dynamic getCachedData(String key) {
    try {
      final cacheEntry = _cacheBox?.get(key);
      if (cacheEntry == null) return null;

      // Check if data has expired
      if (cacheEntry['expires_at'] != null) {
        final expiresAt = cacheEntry['expires_at'] as int;
        if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
          _cacheBox?.delete(key);
          return null;
        }
      }

      return cacheEntry['data'];
    } catch (e) {
      print('❌ Failed to retrieve cached data: $e');
      return null;
    }
  }

  /// Clear expired cache entries
  static Future<void> clearExpiredCache() async {
    try {
      final keys = _cacheBox?.keys.toList() ?? [];
      final now = DateTime.now().millisecondsSinceEpoch;

      for (final key in keys) {
        final cacheEntry = _cacheBox?.get(key);
        if (cacheEntry != null && cacheEntry['expires_at'] != null) {
          final expiresAt = cacheEntry['expires_at'] as int;
          if (now > expiresAt) {
            await _cacheBox?.delete(key);
          }
        }
      }
      print('✅ Expired cache entries cleared');
    } catch (e) {
      print('❌ Failed to clear expired cache: $e');
    }
  }

  /// Store app settings
  static Future<void> storeSetting(String key, dynamic value) async {
    try {
      await _settingsBox?.put(key, value);
      print('✅ Setting stored: $key');
    } catch (e) {
      print('❌ Failed to store setting: $e');
    }
  }

  /// Retrieve app setting
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    try {
      return _settingsBox?.get(key, defaultValue: defaultValue);
    } catch (e) {
      print('❌ Failed to retrieve setting: $e');
      return defaultValue;
    }
  }

  /// Close database connections
  static Future<void> close() async {
    try {
      await _database?.close();
      await _cacheBox?.close();
      await _authBox?.close();
      await _settingsBox?.close();
      print('✅ Database connections closed');
    } catch (e) {
      print('❌ Failed to close database connections: $e');
    }
  }

  /// Get database instance
  static Database? get database => _database;

  /// Check if database is initialized
  static bool get isInitialized => _database != null && _cacheBox != null;
}