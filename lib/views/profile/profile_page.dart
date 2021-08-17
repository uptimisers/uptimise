import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/achievement.dart';
import '../../models/user.dart';
import '../app_bar.dart';
import 'achievement_card.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final achievementIds = ['pi_hours']; // TODO: fetch from provider in AppUser

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Profile',
        showProfile: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.info.photoURL!),
                radius: 28,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.info.displayName!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '@username',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              trailing: OutlinedButton(onPressed: () {}, child: const Text('Edit')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Hours',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '0', // TODO: profile hours
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Follwers',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '0', // TODO: followers
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Following',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          '0', // TODO: following
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            // TODO: do more validation for achievementIds
            ...achievementIds.map((id) => AchievementCard(achievements[id]!)),
          ],
        ),
      ),
    );
  }
}
