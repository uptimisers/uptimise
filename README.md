# Uptimise

## System Requirements

To run Uptimise, your device must be capable of running at least one of

- iOS 10.0,
- Android 5.0 (Lollipop),
- macOS 10.12 (Sierra), or
- most modern web browsers.

## Code / Asset Generation

```bash
# For autoroute
flutter packages pub run build_runner build; # Generates once
flutter packages pub run build_runner watch; # Generates upon file change

# For app icon (iOS and Android only)
flutter pub run flutter_launcher_icons:main; # Generates app icons

# For splash screen (iOS, Android, and macOS only)
flutter pub run flutter_native_splash:create; # Generates splash screen
flutter pub run flutter_native_splash:remove; # Reverts splash screen generation
```

## Integration Testing

```bash
# Mobile / Desktop
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d [device_id];

# Web
chromedriver --port=4444;
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart  -d web-server;
```
