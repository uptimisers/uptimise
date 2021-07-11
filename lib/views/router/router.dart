import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../home/home_page.dart';
import '../not_found/not_found_page.dart';
import 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute<void>(
      path: '/',
      page: HomePage,
    ),
    AutoRoute<void>(
      path: '*',
      page: NotFoundPage,
    ),
  ],
)
class $AppRouter {}

final routerProvider = Provider((ref) => AppRouter());
