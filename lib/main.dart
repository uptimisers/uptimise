import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/analytics_service.dart';
import 'services/log_service.dart';
import 'services/prefs_service.dart';
import 'views/router/router.dart';
import 'views/theme.dart';

Future<void> main() async {
  final container = ProviderContainer();
  final log = container.read(loggerProvider);

  FlutterError.onError = (details) {
    log.w(
      'Uncaught Flutter Error (thrown ${details.context.toString()})',
      details.exception,
      details.stack,
      details.informationCollector == null ? [] : details.informationCollector!(),
    );
  };
  await runZonedGuarded<Future<void>>(
    () => setupAndRunApp(container),
    (e, s) => log.e('Uncaught Dart Error', e, s),
  );
}

Future<void> setupAndRunApp(ProviderContainer container) async {
  final log = container.read(loggerProvider);
  final analytics = container.read(analyticsProvider);

  // Status bar
  final platformBrightness = PlatformDispatcher.instance.platformBrightness;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: platformBrightness,
    statusBarIconBrightness:
        platformBrightness == Brightness.light ? Brightness.dark : Brightness.light,
  ));

  // Web URL Strategy
  setPathUrlStrategy();

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  log.firebaseAppInitializationCompleter.complete(); // allows crashlytics reporting to continue

  // SharedPreferences
  container.read(prefsProvider); // trigger initialisation
  await prefsInitCompleter.future; // wait for initialisation to complete

  // Analytics
  final prefs = container.read(prefsProvider).data!.value;
  final isAnalyticsEnabled = prefs.getBool(kIsAnalyticsEnabled) ?? false;
  await analytics.setIsCollectionEnabled(isAnalyticsEnabled);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analytics = ref.read(analyticsProvider);
    final theme = ref.watch(themeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.read(routerProvider);

    // Update status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: theme.brightness,
      statusBarIconBrightness:
          theme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));

    final analyticsObserver = analytics.navigationObserver;
    return MaterialApp.router(
      title: 'Uptimise',
      // Theming
      themeMode: themeMode.state,
      theme: lightTheme.data,
      // Routing
      routerDelegate: router.delegate(
        navigatorObservers: () => [
          if (analyticsObserver != null) analyticsObserver,
        ],
      ),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
