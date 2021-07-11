import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kIsAnalyticsEnabled = 'isAnalyticsEnabled';
const kThemeMode = 'themeMode';

// Workaround for https://github.com/rrousselGit/river_pod/issues/329
final prefsInitCompleter = Completer<void>();
final prefsProvider = FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  prefsInitCompleter.complete();
  return prefs;
});
