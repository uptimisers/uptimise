import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../models/task.dart';
import '../app_bar.dart';
import '../router/router.dart';
import '../router/router.gr.dart';
import '../theme.dart';
import 'bottom_app_bar.dart';
import 'dashboard/dashboard_page.dart';
import 'tasks/tasks_page.dart';

mixin HomeTabPage {
  String get title;
  IconData get iconData;
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);

    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        TasksRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppAppBar(
            title: [
              const DashboardPage().title,
              const TasksPage().title,
            ][tabsRouter.activeIndex],
            showProfile: true,
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.add_rounded,
            activeIcon: Icons.close_rounded,
            spacing: 16,
            children: [
              SpeedDialChild(
                label: 'Start session',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                onTap: () => router.push(const StartSessionRoute()),
                child: Icon(Icons.av_timer_rounded, color: theme.primary),
              ),
              SpeedDialChild(
                label: 'Import task',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                onTap: () => router.push(const ImportTaskRoute()),
                child: Icon(Icons.cloud_upload_rounded, color: theme.primary),
              ),
              SpeedDialChild(
                label: 'Create task',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                onTap: () {
                  // TODO: Uncomment router.push and remove Task.create
                  // router.push(const CreateTaskRoute());
                  Task.create(
                    ref,
                    title: 'Temporary Placeholder',
                    subject: 'test',
                    dueDateTime: Jiffy(),
                    priority: TaskPriority.low,
                  );
                },
                child: Icon(Icons.task_rounded, color: theme.primary),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: const HomeBottomAppBar(),
          body: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: Container(
              key: ValueKey(tabsRouter.activeIndex),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
