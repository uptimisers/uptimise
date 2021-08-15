import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../router/router.gr.dart';
import 'bottom_app_bar.dart';
import 'calendar/calendar_page.dart';
import 'dashboard/dashboard_page.dart';
import 'tasks/tasks_page.dart';
import 'tools/tools_page.dart';

mixin HomeTabPage {
  String get title;
  IconData get iconData;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: route to/show dialog
            },
            child: const Icon(Icons.add_rounded),
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
