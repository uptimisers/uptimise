import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/achievement.dart';
import '../models/task.dart';
import '../services/prefs_service.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final prefs = ref.watch(prefsProvider).data!.value;
  final themeModeIndex = prefs.getInt(kThemeMode) ?? ThemeMode.system.index;
  return ThemeMode.values[themeModeIndex];
});
final themeProvider = Provider<AppTheme>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  switch (themeMode.state) {
    case ThemeMode.system:
      switch (PlatformDispatcher.instance.platformBrightness) {
        case Brightness.light:
        case Brightness.dark:
          return lightTheme;
      }
    case ThemeMode.light:
    case ThemeMode.dark:
      return lightTheme;
  }
});

class AppTheme {
  const AppTheme({
    required this.brightness,
    required Color primary50,
    required Color primary100,
    required Color primary200,
    required Color primary300,
    required Color primary400,
    required Color primary500,
    required Color primary600,
    required Color primary700,
    required Color primary800,
    required Color primary900,
    required this.background,
    required this.backgroundAccented,
    required this.foreground,
    required this.foregroundAccented,
    required this.foregroundWeak,
    required Color error,
    required this.hyperlink,
    required this.hyperlinkDisabled,
    required this.taskPriorityColors,
    required this.achievementLevelColors,
  })  : _primary50 = primary50,
        _primary100 = primary100,
        _primary200 = primary200,
        _primary300 = primary300,
        _primary400 = primary400,
        _primary500 = primary500,
        _primary600 = primary600,
        _primary700 = primary700,
        _primary800 = primary800,
        _primary900 = primary900,
        _error = error;

  final Brightness brightness;

  final Color _primary50;
  final Color _primary100;
  final Color _primary200;
  final Color _primary300;
  final Color _primary400;
  final Color _primary500;
  final Color _primary600;
  final Color _primary700;
  final Color _primary800;
  final Color _primary900;

  final Color background;
  final Color backgroundAccented;

  final Color foreground;
  final Color foregroundAccented;
  final Color foregroundWeak;

  final Color _error;

  final Color hyperlink;
  final Color hyperlinkDisabled;

  final Map<TaskPriority, Color> taskPriorityColors;
  final Map<AchievementLevel, Color> achievementLevelColors;

  Color get primary => _primary500;
  Color get primaryWeak => _primary200;
  Color get primaryStrong => _primary700;

  Color get shimmerBase => _primary200;
  Color get shimmerHighlight => _primary100;

  ThemeData get data => ThemeData(
        brightness: brightness,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: MaterialColor(_primary500.value, {
          50: _primary50,
          100: _primary100,
          200: _primary200,
          300: _primary300,
          400: _primary400,
          500: _primary500,
          600: _primary600,
          700: _primary700,
          800: _primary800,
          900: _primary900,
        }),
        canvasColor: backgroundAccented,
        highlightColor: _primary100,
        splashColor: _primary600,
        errorColor: _error,
        buttonColor: primary,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          splashColor: primaryStrong,
        ),
        iconTheme: IconThemeData(color: foregroundAccented),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          elevation: 0,
          color: backgroundAccented,
          iconTheme: IconThemeData(color: foreground),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: foreground,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: false,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: foregroundAccented,
          contentTextStyle: TextStyle(color: backgroundAccented),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: foreground),
          headline2: TextStyle(color: foreground),
          headline3: TextStyle(color: foreground),
          headline4: TextStyle(
            color: foreground,
            fontWeight: FontWeight.w600, // used for "Start Uptimising" text
          ),
          headline5: TextStyle(color: foreground),
          headline6: TextStyle(color: foreground),
          subtitle1: TextStyle(color: foreground),
          subtitle2: TextStyle(color: foreground),
          bodyText1: TextStyle(color: foreground),
          bodyText2: TextStyle(color: foregroundAccented),
          button: TextStyle(
            color: foreground,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
          caption: TextStyle(color: foreground),
          overline: TextStyle(
            color: foregroundAccented,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primary,
        ),
        cardTheme: CardTheme(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  TextStyle get codeTextStyle => TextStyle(
        color: foregroundAccented,
        fontSize: 11,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  TextStyle get finePrintTextStyle => TextStyle(
        color: foregroundAccented,
        fontWeight: FontWeight.w300,
        fontSize: 13,
      );
}

const lightTheme = AppTheme(
  brightness: Brightness.light,
  // Primary
  primary50: Color(0xFFE4F2FF),
  primary100: Color(0xFFBEDDFF),
  primary200: Color(0xFF93C8FF),
  primary300: Color(0xFF67B2FF),
  primary400: Color(0xFF4AA1FF),
  primary500: Color(0xFF3A90FF),
  primary600: Color(0xFF3E82FF),
  primary700: Color(0xFF3F6FEA),
  primary800: Color(0xFF3F5CD7),
  primary900: Color(0xFF3D3AB7),
  // Background
  background: Color(0xFFFFFFFF),
  backgroundAccented: Color(0xFFF3F6FF),
  // Foreground
  foreground: Color(0xFF2E3440),
  foregroundAccented: Color(0xFF636F85),
  foregroundWeak: Color(0xFFEDEFF6),
  // Error
  error: Color(0xFFFF6961),
  // Hyperlink
  hyperlink: Color(0xFF0097A7),
  hyperlinkDisabled: Color(0xFF607D8B),
  // Task Priority
  taskPriorityColors: {
    TaskPriority.veryHigh: Color(0xFFEFC7D2),
    TaskPriority.high: Color(0xFFFFD6C3),
    TaskPriority.low: Color(0xFFC7EBDC),
  },
  // Achievement Level
  achievementLevelColors: {
    AchievementLevel.veryHigh: Color(0xFFEFC7D2),
    AchievementLevel.high: Color(0xFFFFD6C3),
    AchievementLevel.low: Color(0xFFC7EBDC),
  },
);
