# ELDERA Mobile App — Hardware & OS Requirements

## Scope
- This document defines the minimum and recommended mobile device specifications to reliably run the ELDERA Flutter app.
- Current repository is configured for Android. iOS support can be added later but is not present in this repo.

## Supported Platforms
- Android (primary)
  - Build config defers SDK values to the Flutter toolchain: see [build.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/app/build.gradle.kts#L1-L49)
  - Permissions defined in [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L1-L84)
- iOS (not configured in repo)
  - No ios/ directory is present; targets and entitlements would be defined in a future setup.

## Minimum Device Specifications (Android)
- OS Version: Android 5.0 (API 21) or higher
  - Flutter’s default minSdk is 21; project uses `minSdk = flutter.minSdkVersion` [build.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/app/build.gradle.kts#L23-L32)
-                   
  - 64-bit ARM (arm64-v8a) strongly recommended to meet modern Play Store requirements
- RAM: 2 GB
  - App uses local notifications, TTS, calendar access; 2 GB avoids background-kill instability
- Storage: 200 MB free for app + 1 GB for data/cache
  - Uses Hive, secure storage, cached images, and local notification assets
- Display: 720p (1280×720), 5-inch, hardware-accelerated GPU
  - Flutter requires GPU acceleration; OpenGL ES 2.0+ or Vulkan-capable devices
- Connectivity: Stable Wi‑Fi or 4G/5G; outbound HTTPS to API endpoints
- Audio: Built-in speaker for Text-to-Speech playback
- Vibration Motor: Recommended for notification feedback

## Recommended Device Specifications (Android)
- OS Version: Android 9 (API 28) or higher (prefer Android 13/14 for modern notification APIs)
- CPU: ARM64, 4+ cores
- RAM: 4 GB
- Storage: 4 GB free (for media, offline data, logs)
- Display: 1080p or higher, 6-inch+, standard DPI, hardware acceleration enabled
- Connectivity: Dual-band Wi‑Fi (2.4/5 GHz) + LTE/5G
- Sensors: Standard accelerometer/gyroscope acceptable; GPS optional

## Required Features and Permissions (Android)
- Network and runtime services:
  - INTERNET, ACCESS_NETWORK_STATE, WAKE_LOCK, FOREGROUND_SERVICE [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L2-L13)
  - POST_NOTIFICATIONS (Android 13+) [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L4)
  - SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM (for precise reminders) [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L7-L8)
  - RECEIVE_BOOT_COMPLETED (reschedule after reboot) [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L9)
  - FOREGROUND_SERVICE_SPECIAL_USE (for critical scheduling paths) [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L11)
- Calendar:
  - READ_CALENDAR, WRITE_CALENDAR [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L16-L18)
- Notifications:
  - Uses flutter_local_notifications; exact scheduling on modern Android versions [local_notification_service.dart](file:///c:/capstoneIMS_ELDERA/eldera/lib/services/local_notification_service.dart#L294-L333)
- Audio:
  - Text-to-Speech requires speaker output [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
- Storage:
  - Hive and secure storage require persistent storage [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
- Optional media:
  - Image picker may prompt for camera/photos access on devices (not strictly required in manifest yet)

## Dependency Considerations (Android)
- Key packages and their hardware/OS implications: see [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L10-L49)
  - flutter_local_notifications: modern notification APIs; runtime permission on Android 13+
  - device_calendar: reads/writes Calendar Provider; requires calendar permissions
  - flutter_tts: audio output; ensure volume and speaker functioning
  - hive_flutter / flutter_secure_storage: persistent storage; encryption friendly hardware
  - audioplayers: audio playback; standard media stack
  - image_picker: optional camera/gallery access depending on features used

## Enterprise/MDM Notes
- Battery Optimization: Whitelist app for exact alarms and timely notifications on Android 12+
- Background Execution: Foreground service permission enables consistent scheduling
- TLS/HTTPS: Devices must trust your CA chain for API endpoints
- Storage Policies: Allow app data write access to internal app storage

## iOS (Future Support)
- Not currently configured in repository.
- Typical baseline when added:
  - iOS 12+ (recommended iOS 14+)
  - Notifications and Calendar entitlements
  - Network access over HTTPS

## Test Device Recommendations
- Budget: Android 10, ARM64, 3 GB RAM, 32 GB storage, 6.1" 1080p
- Mid-range: Android 13/14, ARM64, 6 GB RAM, 128 GB storage, 6.5" 1080p/120 Hz
- Accessibility: Devices with loud speakers and good haptic feedback are preferred for seniors

## References
- Build and SDK configuration: [build.gradle.kts](file:///c:/capstoneIMS_ELDERA/eldera/android/app/build.gradle.kts#L1-L49)
- Android permissions: [AndroidManifest.xml](file:///c:/capstoneIMS_ELDERA/eldera/android/app/src/main/AndroidManifest.xml#L1-L84)
- Dependencies: [pubspec.yaml](file:///c:/capstoneIMS_ELDERA/eldera/pubspec.yaml#L1-L49)
