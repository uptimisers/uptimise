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
                  const SizedBox(height: 4),
                  Text(
                    '@skytect',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              trailing: OutlinedButton(
                onPressed: () {
                  // TODO: set up editing username
                },
                child: const Text('Edit'),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ProfileCounter(
                  title: 'Hours',
                  count: '32', // TODO: fetch from provider in AppUser
                ),
                // TODO: implement following
                ProfileCounter(
                  title: 'Followers',
                  count: 'coming soon',
                ),
                ProfileCounter(
                  title: 'Following',
                  count: 'coming soon',
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListTile(
              title: Text(
                'Achievements',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            // TODO: do more validation for achievementIds
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                children: [
                  ...achievementIds.map((id) => AchievementCard(achievements[id]!)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCounter extends StatelessWidget {
  const ProfileCounter({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          count,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
