import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme.dart';
import 'calendar/calendar_page.dart';
import 'dashboard/dashboard_page.dart';
import 'home_page.dart';
import 'tasks/tasks_page.dart';

class HomeBottomAppBar extends ConsumerWidget {
  const HomeBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsRouter = AutoTabsRouter.of(context);
    final theme = ref.watch(themeProvider);

    Widget toTabItem(int index, HomeTabPage tabPage) {
      return IconButton(
        tooltip: tabPage.title,
        iconSize: 32,
        icon: Icon(tabPage.iconData),
        color: tabsRouter.activeIndex == index ? theme.primary : null,
        onPressed: () {
          tabsRouter.setActiveIndex(index);
        },
      );
    }

    return BottomAppBar(
      elevation: 0,
      color: theme.backgroundAccented,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              toTabItem(0, const DashboardPage()),
              toTabItem(1, const TasksPage()),
              toTabItem(2, const CalendarPage()),
            ],
          ),
        ),
      ),
    );
  }
}
