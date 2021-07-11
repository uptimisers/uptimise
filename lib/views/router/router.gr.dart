// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../home/home_page.dart' as _i3;
import '../not_found/not_found_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomePage();
        }),
    NotFoundRoute.name: (routeData) => _i1.MaterialPageX<void>(
        routeData: routeData,
        builder: (_) {
          return const _i4.NotFoundPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(NotFoundRoute.name, path: '*')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class NotFoundRoute extends _i1.PageRouteInfo {
  const NotFoundRoute() : super(name, path: '*');

  static const String name = 'NotFoundRoute';
}
