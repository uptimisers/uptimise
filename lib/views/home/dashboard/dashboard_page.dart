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

    // TODO: move to balloon class
    final altitude = useState<double>(482.5);
    var fuelCount = 0;
    var fuelCountLoaded = false;
    if (incompleteTasks.data != null) {
      fuelCountLoaded = true;
      for (final task in incompleteTasks.data!.value) {
        fuelCount += [38, 57, 76][task.priority.index];
      }
    } else {
      fuelCountLoaded = false;
    }

    // workaround to rebuild every minute
    final _timer = useState(0);
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        ++_timer.value;
        altitude.value += session != null ? .003 : .001; // TODO
      });
      return timer.cancel;
    });

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 32),
        Image.asset(
          'assets/images/balloon.png',
          height: 128,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardCounter(
              title: 'Altitude',
              count: altitude.value == 1
                  ? '${altitude.value.toStringAsFixed(1)} metre'
                  : '${altitude.value.toStringAsFixed(1)} metres',
            ),
            DashboardCounter(
              title: 'Fuel',
              count: fuelCountLoaded
                  ? fuelCount == 1
                      ? '$fuelCount litre'
                      : '$fuelCount litres'
                  : '... litres',
            ),
          ],
        ),
        const SizedBox(height: 16),
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

class DashboardCounter extends StatelessWidget {
  const DashboardCounter({
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
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          count,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
