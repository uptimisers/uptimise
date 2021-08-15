// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:uptimise/views/home/calendar/calendar_page.dart' as _i9;
import 'package:uptimise/views/home/dashboard/dashboard_page.dart' as _i7;
import 'package:uptimise/views/home/home_page.dart' as _i4;
import 'package:uptimise/views/home/tasks/tasks_page.dart' as _i8;
import 'package:uptimise/views/home/tools/tools_page.dart' as _i10;
import 'package:uptimise/views/not_found/not_found_page.dart' as _i6;
import 'package:uptimise/views/router/router.dart' as _i3;
import 'package:uptimise/views/sign_in/sign_in_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.authGuard,
      required this.alreadyAuthedGuard})
      : super(navigatorKey);

  final _i3.AuthGuard authGuard;

  final _i3.AlreadyAuthedGuard alreadyAuthedGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i4.HomePage();
        }),
    SignInRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i5.SignInPage();
        }),
    NotFoundRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i6.NotFoundPage();
        }),
    DashboardRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i7.DashboardPage();
        }),
    TasksRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i8.TasksPage();
        }),
    CalendarRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i9.CalendarPage();
        }),
    ToolsRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i10.ToolsPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i1.RouteConfig(DashboardRoute.name, path: 'dashboard'),
          _i1.RouteConfig(TasksRoute.name, path: 'tasks'),
          _i1.RouteConfig(CalendarRoute.name, path: 'calendar'),
          _i1.RouteConfig(ToolsRoute.name, path: 'tools')
        ]),
        _i1.RouteConfig(SignInRoute.name,
            path: '/signin', guards: [alreadyAuthedGuard]),
        _i1.RouteConfig(NotFoundRoute.name, path: '*')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/signin');

  static const String name = 'SignInRoute';
}

class NotFoundRoute extends _i1.PageRouteInfo {
  const NotFoundRoute() : super(name, path: '*');

  static const String name = 'NotFoundRoute';
}

class DashboardRoute extends _i1.PageRouteInfo {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

class TasksRoute extends _i1.PageRouteInfo {
  const TasksRoute() : super(name, path: 'tasks');

  static const String name = 'TasksRoute';
}

class CalendarRoute extends _i1.PageRouteInfo {
  const CalendarRoute() : super(name, path: 'calendar');

  static const String name = 'CalendarRoute';
}

class ToolsRoute extends _i1.PageRouteInfo {
  const ToolsRoute() : super(name, path: 'tools');

  static const String name = 'ToolsRoute';
}
