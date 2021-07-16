import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kIsAnalyticsEnabled = 'isAnalyticsEnabled';
const kThemeMode = 'themeMode';

final prefsProvider =
    FutureProvider<SharedPreferences>((ref) async => SharedPreferences.getInstance());
