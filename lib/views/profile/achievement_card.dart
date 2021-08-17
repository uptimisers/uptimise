import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/achievement.dart';
import '../theme.dart';

class AchievementCard extends ConsumerWidget {
  const AchievementCard(this.achievement, {Key? key}) : super(key: key);

  final Achievement achievement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Card(
      color: theme.achievementLevelColors[achievement.level],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          leading: Icon(IconData(achievement.icon, fontFamily: 'MaterialIcons')),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    achievement.title,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    ['Level 3', 'Level 2', 'Level 1'][achievement.level.index],
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                achievement.description,
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
