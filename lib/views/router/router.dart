import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/auth_service.dart';
import '../home/dashboard/dashboard_page.dart';
import '../home/home_page.dart';
import '../home/sessions/start_session_page.dart';
import '../home/tasks/create_task_page.dart';
import '../home/tasks/import_task_page.dart';
import '../home/tasks/task_detail.dart';
import '../home/tasks/tasks_page.dart';
import '../not_found/not_found_page.dart';
import '../profile/profile_page.dart';
import '../settings/settings_page.dart';
import '../sign_in/sign_in_page.dart';
import 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute<void>(
      path: '/',
      page: HomePage,
      guards: [AuthGuard],
      children: [
        AutoRoute<void>(
          path: 'dashboard',
          page: DashboardPage,
        ),
        AutoRoute<void>(
          path: 'tasks',
          page: TasksPage,
        ),
      ],
    ),
    AutoRoute<void>(
      path: '/task/:id',
      page: TaskDetailPage,
    ),
    AutoRoute<void>(
      path: '/create-task',
      page: CreateTaskPage,
    ),
    AutoRoute<void>(
      path: '/import-task',
      page: ImportTaskPage,
    ),
    AutoRoute<void>(
      path: '/start-session',
      page: StartSessionPage,
    ),
    AutoRoute<void>(
      path: '/profile',
      page: ProfilePage,
      guards: [AuthGuard],
    ),
    AutoRoute<void>(
      path: '/settings',
      page: SettingsPage,
      guards: [AuthGuard],
    ),
    AutoRoute<void>(
      path: '/signin',
      page: SignInPage,
      guards: [AlreadyAuthedGuard],
    ),
    AutoRoute<void>(
      path: '*',
      page: NotFoundPage,
    ),
  ],
)
class $AppRouter {}

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);

  final ProviderRef ref;

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = ref.read(authProvider);
    if (auth.isSignedIn) {
      resolver.next();
    } else {
      await router.push(const SignInRoute());
      resolver.next(false);
    }
  }
}

class AlreadyAuthedGuard extends AutoRouteGuard {
  AlreadyAuthedGuard(this.ref);

  final ProviderRef ref;

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = ref.read(authProvider);
    if (!auth.isSignedIn) {
      resolver.next();
    } else {
      final path = router.current.queryParams.get('to', '/') as String;
      await router.pushNamed(path);
      resolver.next(false);
    }
  }
}

final routerProvider = Provider((ref) => AppRouter(
      authGuard: AuthGuard(ref),
      alreadyAuthedGuard: AlreadyAuthedGuard(ref),
    ));
