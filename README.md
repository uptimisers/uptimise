<h1 align="center">Uptimise</h1>

<p align="center">
  <img src="https://github.com/uptimisers/uptimise/blob/main/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png" alt="App Icon" width="128">
  <br>
</p>

<p align="center">
  <a href="https://github.com/uptimisers/uptimise/releases"><img src="https://img.shields.io/github/v/release/uptimisers/uptimise?include_prereleases" alt="Releases"></a>
  <a href="https://github.com/uptimisers/uptimise/actions/workflows/checks.yml"><img src="https://img.shields.io/github/workflow/status/uptimisers/uptimise/Checks/main?label=checks" alt="Checks"></a>
  <a href="https://github.com/uptimisers/uptimise/actions/workflows/integration-tests.yml"><img src="https://img.shields.io/github/workflow/status/uptimisers/uptimise/Integration%20Tests/main?label=integration%20tests" alt="Integration Tests"></a>
  <a href="https://stats.uptimerobot.com/EKGY3fWrrX"><img src="https://img.shields.io/uptimerobot/ratio/7/m788675632-34c4a32e58d037a3462a34dd" alt="Uptime"></a>
</p>

<hr>

## System Requirements

To run Uptimise, your device must be capable of running at least one of

- iOS 10.0,
- Android 5.0 (Lollipop),
- macOS 10.12 (Sierra), or
- most modern web browsers.

## Running

```bash
flutter run # Runs the app in development mode

# To run on web, you need to specify the port as 5000 for Google sign in to work
flutter run -d chrome --web-hostname localhost --web-port 5000
```

## Code / Asset Generation

```bash
# For autoroute
flutter packages pub run build_runner build --delete-conflicting-outputs; # Generates once
flutter packages pub run build_runner watch --delete-conflicting-outputs; # Generates upon file change

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
