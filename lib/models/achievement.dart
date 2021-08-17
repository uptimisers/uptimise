import 'package:flutter/material.dart';

enum AchievementLevel { veryHigh, high, low }

class Achievement {
  const Achievement({
    required this.title,
    required this.description,
    required this.iconData,
    required this.level,
  });

  final String title;
  final String description;
  final IconData iconData;
  final AchievementLevel level;
}

const achievements = <String, Achievement>{
  'pi_hours': Achievement(
    title: 'Pi',
    description: 'Achieve 3.14 hours of mugging in one sitting',
    iconData: Icons.functions_rounded,
    level: AchievementLevel.low,
  ),
};
