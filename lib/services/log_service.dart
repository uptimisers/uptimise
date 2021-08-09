import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pedantic/pedantic.dart';

import 'crashlytics_service.dart';

final loggerProvider = Provider<AppLogger>((ref) => AppLogger());

mixin LoggerMixin {
  ProviderRefBase get ref;

  late final log = ref.read(loggerProvider);
}

class AppLogger {
  AppLogger() {
    final simplePrinter = SimplePrinter(
      colors: false,
      printTime: true,
    );
    final prettyPrinter = PrettyPrinter(
      colors: false,
      methodCount: 8,
      errorMethodCount: 16,
      printTime: true,
    );
    _logger = Logger(
      printer: HybridPrinter(
        simplePrinter,
        wtf: prettyPrinter,
        error: prettyPrinter,
        warning: prettyPrinter,
      ),
    );
    _crashlytics =
        !kIsWeb && kReleaseMode ? FirebaseCrashlyticsService() : DummyCrashlyticsService();
  }

  late final Logger _logger;
  late final CrashlyticsService _crashlytics;
  final firebaseAppInitializationCompleter = Completer<void>();

  void wtf(String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) {
    _log(Level.wtf, message, exception, stack, information);
  }

  void e(String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) {
    _log(Level.error, message, exception, stack, information);
  }

  void w(String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) {
    _log(Level.warning, message, exception, stack, information);
  }

  void i(String message, [StackTrace? stack]) {
    _log(Level.info, message, stack);
  }

  void d(String message, [StackTrace? stack]) {
    _log(Level.debug, message, stack);
  }

  void v(String message, [StackTrace? stack]) {
    _log(Level.verbose, message, stack);
  }

  void _log(Level level, String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) {
    _logger.log(level, message, exception, stack);
    unawaited(_logToCrashlytics(level, message, exception, stack, information));
  }

  Future<void> _logToCrashlytics(Level level, String message, Object? exception, StackTrace? stack,
      Iterable<DiagnosticsNode>? information) async {
    try {
      await firebaseAppInitializationCompleter.future;
      await _crashlytics.log(level, message, exception, stack, information);
    } catch (e, s) {
      debugPrint('[CRASHLYTICS FAILED]\n$e\n$s');
    }
  }

  Future<void> setUserId({String? id}) async {
    await firebaseAppInitializationCompleter.future;
    _crashlytics.setUserId(id: id);
  }
}
