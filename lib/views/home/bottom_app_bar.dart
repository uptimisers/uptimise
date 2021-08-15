import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../theme.dart';

class TabItem {
  const TabItem({
    required this.index,
    required this.title,
    required this.icon,
  }) : isSpacer = false;

  const TabItem.spacer()
      : isSpacer = true,
        index = null,
        title = null,
        icon = null;

  final bool isSpacer;
  final int? index;
  final String? title;
  final IconData? icon;
}

class AppBottomAppBar extends ConsumerWidget {
  const AppBottomAppBar({Key? key, required this.tabsRouter}) : super(key: key);

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeProvider);

    const tabItems = [
      TabItem(index: 0, title: 'Dashboard', icon: Icons.dashboard_rounded),
      TabItem(index: 1, title: 'Tasks', icon: Icons.list_rounded),
      TabItem.spacer(),
      TabItem(index: 2, title: 'Calendar', icon: Icons.calendar_today_rounded),
      TabItem(index: 3, title: 'Tools', icon: Icons.handyman_rounded),
    ];

    return BottomAppBar(
      elevation: 0,
      color: theme.backgroundAccented,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...tabItems.map(
              (tabItem) {
                if (tabItem.isSpacer) {
                  return const SizedBox();
                } else {
                  return IconButton(
                    tooltip: tabItem.title,
                    iconSize: 32,
                    icon: Icon(tabItem.icon),
                    color: tabsRouter.activeIndex == tabItem.index ? theme.primary : null,
                    onPressed: () {
                      tabsRouter.setActiveIndex(tabItem.index!);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
