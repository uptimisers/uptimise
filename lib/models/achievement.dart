import 'package:cloud_firestore/cloud_firestore.dart';

enum AchievementLevel { veryHigh, high, low }

class Achievement {
  const Achievement({
    // required this.doc,
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.level,
  });

  // Achievement.fromDoc(DocumentSnapshot snapshot)
  //     : doc = snapshot.reference,
  //       id = snapshot.id,
  //       title = snapshot.get('title') as String,
  //       description = snapshot.get('description') as String,
  //       icon = snapshot.get('icon') as int,
  //       level = AchievementLevel.values[snapshot.get('level') as int];

  // TODO: firestore

  // final DocumentReference doc;
  final String id;
  final String title;
  final String description;
  final int icon;
  final AchievementLevel level;
}
