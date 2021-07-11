# Uptimise

## Code / Asset Generation

```bash
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
