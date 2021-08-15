// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:uptimise/views/home/calendar/calendar_page.dart' as _i15;
import 'package:uptimise/views/home/dashboard/dashboard_page.dart' as _i13;
import 'package:uptimise/views/home/home_page.dart' as _i4;
import 'package:uptimise/views/home/sessions/start_session_page.dart' as _i8;
import 'package:uptimise/views/home/tasks/create_task_page.dart' as _i6;
import 'package:uptimise/views/home/tasks/import_task_page.dart' as _i7;
import 'package:uptimise/views/home/tasks/task_detail.dart' as _i5;
import 'package:uptimise/views/home/tasks/tasks_page.dart' as _i14;
import 'package:uptimise/views/not_found/not_found_page.dart' as _i12;
import 'package:uptimise/views/profile/profile_page.dart' as _i9;
import 'package:uptimise/views/router/router.dart' as _i3;
import 'package:uptimise/views/settings/settings_page.dart' as _i10;
import 'package:uptimise/views/sign_in/sign_in_page.dart' as _i11;

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
    TaskDetailRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<TaskDetailRouteArgs>(
              orElse: () =>
                  TaskDetailRouteArgs(id: pathParams.getString('id')));
          return _i5.TaskDetailPage(key: args.key, id: args.id);
        }),
    CreateTaskRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i6.CreateTaskPage();
        }),
    ImportTaskRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i7.ImportTaskPage();
        }),
    StartSessionRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i8.StartSessionPage();
        }),
    ProfileRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i9.ProfilePage();
        }),
    SettingsRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i10.SettingsPage();
        }),
    SignInRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i11.SignInPage();
        }),
    NotFoundRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i12.NotFoundPage();
        }),
    DashboardRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i13.DashboardPage();
        }),
    TasksRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i14.TasksPage();
        }),
    CalendarRoute.name: (routeData) => _i1.AdaptivePage<void>(
        routeData: routeData,
        builder: (_) {
          return const _i15.CalendarPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/', guards: [
          authGuard
        ], children: [
          _i1.RouteConfig(DashboardRoute.name, path: 'dashboard'),
          _i1.RouteConfig(TasksRoute.name, path: 'tasks'),
          _i1.RouteConfig(CalendarRoute.name, path: 'calendar')
        ]),
        _i1.RouteConfig(TaskDetailRoute.name, path: '/task/:id'),
        _i1.RouteConfig(CreateTaskRoute.name, path: '/create-task'),
        _i1.RouteConfig(ImportTaskRoute.name, path: '/import-task'),
        _i1.RouteConfig(StartSessionRoute.name, path: '/start-session'),
        _i1.RouteConfig(ProfileRoute.name,
            path: '/profile', guards: [authGuard]),
        _i1.RouteConfig(SettingsRoute.name,
            path: '/settings', guards: [authGuard]),
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

class TaskDetailRoute extends _i1.PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({_i2.Key? key, required String id})
      : super(name,
            path: '/task/:id',
            args: TaskDetailRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'TaskDetailRoute';
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.id});

  final _i2.Key? key;

  final String id;
}

class CreateTaskRoute extends _i1.PageRouteInfo {
  const CreateTaskRoute() : super(name, path: '/create-task');

  static const String name = 'CreateTaskRoute';
}

class ImportTaskRoute extends _i1.PageRouteInfo {
  const ImportTaskRoute() : super(name, path: '/import-task');

  static const String name = 'ImportTaskRoute';
}

class StartSessionRoute extends _i1.PageRouteInfo {
  const StartSessionRoute() : super(name, path: '/start-session');

  static const String name = 'StartSessionRoute';
}

class ProfileRoute extends _i1.PageRouteInfo {
  const ProfileRoute() : super(name, path: '/profile');

  static const String name = 'ProfileRoute';
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings');

  static const String name = 'SettingsRoute';
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
