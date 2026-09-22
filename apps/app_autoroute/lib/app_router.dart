import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:feature_splash/splash_screen.dart';
import 'package:feature_auth/login_screen.dart';
import 'package:feature_library/home_shell.dart';
import 'package:feature_library/reader_screen.dart';
import 'package:feature_updates/updates_tab.dart';
import 'package:feature_history/history_tab.dart';
import 'package:feature_browse/browse_tab.dart';
import 'package:feature_more/more_tab.dart';
import 'package:feature_more/simple_screen.dart';
import 'package:nav_autoroute/auto_route_navigator.dart';

part 'app_router.gr.dart';

// NOTE: Run `dart run build_runner build --delete-conflicting-outputs`
// to generate app_router.gr.dart before first launch.

@RoutePage()
class SplashPage extends StatelessWidget {
  final AuthService auth;
  const SplashPage({super.key, required this.auth});
  @override
  Widget build(BuildContext context) => SplashScreen(
        nav: AutoRouteNavigator(context.router),
        bootstrap: () async {},
        isLoggedIn: () => false,
      );
}

@RoutePage()
class LoginPage extends StatelessWidget {
  final AuthService auth;
  const LoginPage({super.key, required this.auth});
  @override
  Widget build(BuildContext context) =>
      LoginScreen(nav: AutoRouteNavigator(context.router), auth: auth);
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final nav = AutoRouteNavigator(context.router);
    return HomeShell(
      nav: nav,
      tabs: [
        // Library page is wired via Riverpod in main.dart's ProviderScope.
        const _RiverpodLibrarySlot(),
        const UpdatesTab(),
        const HistoryTab(),
        const BrowseTab(),
        MoreTab(nav: nav),
      ],
    );
  }
}

class _RiverpodLibrarySlot extends StatelessWidget {
  const _RiverpodLibrarySlot();
  @override
  Widget build(BuildContext context) => const SimpleScreen('Library');
}

@RoutePage()
class WorkDetailsPage extends StatelessWidget {
  final String id;
  const WorkDetailsPage({super.key, @PathParam('id') required this.id});
  @override
  Widget build(BuildContext context) => SimpleScreen('Work $id');
}

@RoutePage()
class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});
  @override
  Widget build(BuildContext context) => const ReaderScreen();
}

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) => const SimpleScreen('About');
}

@RoutePage()
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) => const SimpleScreen('Help');
}

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const SimpleScreen('Settings');
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthService auth;
  AppRouter(this.auth);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: WorkDetailsRoute.page, path: '/home/library/work/:id'),
        AutoRoute(page: ReaderRoute.page, path: '/reader'),
        AutoRoute(page: AboutRoute.page),
        AutoRoute(page: HelpRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
