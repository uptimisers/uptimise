import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app_bar.dart';
import '../router/router.gr.dart';
import '../theme.dart';
import 'bottom_app_bar.dart';
import 'calendar/calendar_page.dart';
import 'dashboard/dashboard_page.dart';
import 'tasks/tasks_page.dart';
import 'tools/tools_page.dart';

mixin HomeTabPage {
  String get title;
  IconData get iconData;
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        TasksRoute(),
        CalendarRoute(),
        ToolsRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppAppBar(
            title: [
              const DashboardPage().title,
              const TasksPage().title,
              const CalendarPage().title,
              const ToolsPage().title
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
                onTap: () {
                  // TODO: show start session dialog
                },
                child: Icon(Icons.av_timer_rounded, color: theme.primary),
              ),
              SpeedDialChild(
                label: 'Import task',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                onTap: () {
                  // TODO: show import task dialog
                },
                child: Icon(Icons.cloud_upload_rounded, color: theme.primary),
              ),
              SpeedDialChild(
                label: 'Create task',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                onTap: () {
                  // TODO: show create task dialog
                },
                child: Icon(Icons.task_rounded, color: theme.primary),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // Custom BottomAppBar used instead of BottomNavigationBar for FAB
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
