import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'log_service.dart';

final analyticsProvider = Provider<AnalyticsService>(
  (ref) => (kIsWeb || !Platform.isMacOS) && kReleaseMode
      ? FirebaseAnalyticsService(ref)
      : DummyAnalyticsService(),
);

mixin AnalyticsServiceMixin {
  ProviderRefBase get ref;

  late final analytics = ref.read(analyticsProvider);
}

abstract class AnalyticsService {
  NavigatorObserver? get navigationObserver;

  // ignore: avoid_positional_boolean_parameters
  Future<void> setIsCollectionEnabled(bool newValue);

  void logEvent({required String name, Map<String, Object?>? parameters});
}

class DummyAnalyticsService implements AnalyticsService {
  @override
  NavigatorObserver? get navigationObserver => null;

  @override
  Future<void> setIsCollectionEnabled(bool newValue) async {}

  @override
  void logEvent({required String name, Map<String, Object?>? parameters}) {}
}

class FirebaseAnalyticsService with LoggerMixin implements AnalyticsService {
  FirebaseAnalyticsService(this.ref);

  @override
  final ProviderRefBase ref;

  final analytics = FirebaseAnalytics();

  @override
  NavigatorObserver? get navigationObserver => FirebaseAnalyticsObserver(
        analytics: FirebaseAnalytics(),
        onError: (e) => log.e('Could not send active route to analytics', e),
      );

  @override
  Future<void> setIsCollectionEnabled(bool newValue) async {
    await analytics.setAnalyticsCollectionEnabled(newValue);
  }

  @override
  void logEvent({required String name, Map<String, Object?>? parameters}) {
    unawaited(analytics.logEvent(name: name, parameters: parameters));
  }
}
