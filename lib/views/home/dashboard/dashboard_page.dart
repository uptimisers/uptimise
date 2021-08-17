import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../models/user.dart';
import '../../router/router.dart';
import '../../router/router.gr.dart';
import '../../theme.dart';
import '../home_page.dart';

class DashboardPage extends HookConsumerWidget with HomeTabPage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  String get title => 'Dashboard';

  @override
  IconData get iconData => Icons.dashboard_rounded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final router = ref.watch(routerProvider);

    final incompleteTasks = ref.watch(user.incompleteTasksProvider);
    final tasksDueSoon = incompleteTasks.data?.value
        .where((task) =>
            Jiffy().isSame(task.dueDateTime, Units.DAY) ||
            Jiffy().add(days: 1).isSame(task.dueDateTime, Units.DAY))
        .toList()
          ?..sort((a, b) => a.dueDateTime.dateTime.compareTo(b.dueDateTime.dateTime));

    final currentSession = ref.watch(user.currentSessionProvider);
    final session = currentSession.data?.value;
    // TODO: set up pomodoro timer
    final sessionTimeLeft =
        session?.startDateTime.clone().add(minutes: 25).diff(Jiffy(), Units.MINUTE);
    // workaround to rebuild every minute
    final _timer = useState(0);
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (timer) => ++_timer.value);
      return timer.cancel;
    });

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        if (tasksDueSoon != null && tasksDueSoon.isNotEmpty)
          DashboardCard(
            iconData: Icons.pending_actions_rounded,
            title: 'Due Soon',
            child: Column(
              children: [
                ...tasksDueSoon.map((task) {
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.subject),
                    onTap: () {
                      router.push(TaskDetailRoute(id: task.id));
                    },
                  );
                }),
              ],
            ),
          ),
        if (session != null)
          DashboardCard(
            iconData: Icons.av_timer_rounded,
            title: 'Session',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle1,
                      children: <TextSpan>[
                        TextSpan(
                          text: '$sessionTimeLeft ',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        TextSpan(
                          text: session.isRest ? 'minutes until work' : 'minutes until break',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: session.end,
                    child: const Text('End'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class DashboardCard extends ConsumerWidget {
  const DashboardCard({
    Key? key,
    required this.iconData,
    required this.title,
    required this.child,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Card(
      color: theme.backgroundAccented,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                iconData,
                color: theme.foreground,
                size: 32,
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
