import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract class CrashlyticsService {
  Future<void> setUserId({String? id});

  Future<void> log(Level level, String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]);
}

class DummyCrashlyticsService implements CrashlyticsService {
  @override
  Future<void> setUserId({String? id}) async {}

  @override
  Future<void> log(Level level, String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) async {}
}

class FirebaseCrashlyticsService implements CrashlyticsService {
  get crashlytics => FirebaseCrashlytics.instance;

  @override
  Future<void> setUserId({String? id}) async {
    if (id != null) {
      await crashlytics.setUserIdentifier(id);
    }
  }

  @override
  Future<void> log(Level level, String message,
      [Object? exception, StackTrace? stack, Iterable<DiagnosticsNode>? information]) async {
    switch (level) {
      case Level.wtf:
      case Level.error:
        return crashlytics.recordError(
          exception,
          stack,
          reason: message,
          information: information ?? const [],
          printDetails: false,
          fatal: true,
        );
      case Level.warning:
        return crashlytics.recordError(
          exception,
          stack,
          reason: message,
          information: information ?? const [],
          printDetails: false,
        );
      case Level.info:
      case Level.debug:
      case Level.verbose:
        return crashlytics.log(message);
      case Level.nothing:
        return;
    }
  }
}
