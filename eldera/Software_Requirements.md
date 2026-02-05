# ELDERA Mobile App — Software Requirements

## Scope
- Defines software prerequisites for using and building the ELDERA Flutter app.
- Focuses on end-user device OS/config and developer build environment.

## Device Software Requirements (Android)
- Supported OS: Android 5.0 (API 21) or higher
  - Project defers minSdk/targetSdk to Flutter toolchain: see [build.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/app/build.gradle.kts#L23-L32)
- Required runtime permissions:
  - Notifications: POST_NOTIFICATIONS (Android 13+) [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L4)
  - Exact alarms: SCHEDULE_EXACT_ALARM, USE_EXACT_ALARM [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L7-L8)
  - Boot receiver: RECEIVE_BOOT_COMPLETED [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L9)
  - Foreground services: FOREGROUND_SERVICE, FOREGROUND_SERVICE_SPECIAL_USE [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L10-L11)
  - Calendar access: READ_CALENDAR, WRITE_CALENDAR [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L16-L18)
- Services and settings:
  - Hardware acceleration enabled (default for Flutter)
  - Battery optimization: allow exact alarms/foreground service for timely reminders
  - Network: HTTPS connectivity with modern TLS (1.2+)
- Locale and accessibility:
  - System language settings supported (app provides language and font size controls)
  - Enable device text-to-speech engine for audio announcements

## App Feature Dependencies (Android)
- Notifications and scheduling:
  - Uses flutter_local_notifications with exact scheduling [local_notification_service.dart](file:///c:/capstoneIMS_ELDERA/eldera/lib/services/local_notification_service.dart#L294-L333)
- Calendar integration:
  - device_calendar for reading/writing events [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
- Secure storage and persistence:
  - flutter_secure_storage and hive_flutter for local data [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
- Audio/TTS:
  - flutter_tts and audioplayers for speech and playback [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
- Optional media:
  - image_picker for camera/gallery (permissions prompted when used)

## Development/Build Environment (Android)
- Flutter SDK: Flutter 3+ (project env specifies flutter >= 3.0.0) [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L6-L8)
- Dart SDK: >= 3.6.1 < 4.0.0 [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L6-L8)
- JDK: Java 17 (configured) [gradle.properties](file:///c:/capstoneIMS_ELDERA/eldera/android/gradle.properties#L1-L4)
- Android Gradle Plugin: 8.9.1, Kotlin: 2.1.0 [settings.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/settings.gradle.kts#L19-L25)
- IDE: Android Studio or VS Code with Flutter/Dart plugins
- Commands:
  - flutter pub get
  - flutter run

## iOS (Future Support)
- Not present in this repository (no ios/ directory).
- When added, typical requirements:
  - iOS 12+ (recommended iOS 14+)
  - Notification and calendar entitlements
  - Xcode with Flutter integration

## References
- Build config: [build.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/app/build.gradle.kts#L1-L49)
- Manifest permissions: [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L1-L84)
- Dependencies: [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L1-L49)
