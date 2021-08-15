import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.gr.dart';
import 'bottom_app_bar.dart';

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO
            },
            child: const Icon(Icons.add_rounded),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // Custom BottomAppBar used instead of BottomNavigationBar for FAB
          bottomNavigationBar: AppBottomAppBar(tabsRouter: tabsRouter),
        );
      },
    );
  }
}
