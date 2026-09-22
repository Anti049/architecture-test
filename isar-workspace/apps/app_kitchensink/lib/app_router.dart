import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_domain/core_domain.dart';
import 'package:feature_auth/login_screen.dart';
import 'package:feature_browse/browse_tab.dart';
import 'package:feature_history/history_tab.dart';
import 'package:feature_library/home_shell.dart';
import 'package:feature_library/reader_screen.dart';
import 'package:feature_more/more_tab.dart';
import 'package:feature_more/simple_screen.dart';
import 'package:feature_splash/splash_screen.dart';
import 'package:feature_updates/updates_tab.dart';
import 'package:nav_contract/nav_contract.dart';
import 'auto_route_navigator.dart';
import 'library_cubit.dart';
import 'library_page.dart';

part 'app_router.gr.dart';

AppRouter _appRouter(BuildContext context) => context.router.root as AppRouter;

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = _appRouter(context);
    return SplashScreen(
      nav: LocalAutoRouteNavigator(context.router),
      bootstrap: () async {
        await router.libraryCubit.repo.getLibrary();
      },
      isLoggedIn: () => false,
    );
  }
}

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) =>
      LoginScreen(
        nav: LocalAutoRouteNavigator(context.router),
        auth: _appRouter(context).auth,
      );
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = _appRouter(context);
    final nav = LocalAutoRouteNavigator(context.router);
    return BlocProvider.value(
      value: router.libraryCubit..load(),
      child: HomeShell(
        nav: nav,
        tabs: [
          LibraryPage(nav),
          const UpdatesTab(),
          const HistoryTab(),
          const BrowseTab(),
          MoreTab(nav: nav),
        ],
      ),
    );
  }
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
  final LibraryCubit libraryCubit;

  AppRouter({required this.auth, required this.libraryCubit});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: Routes.splash, initial: true),
        AutoRoute(page: LoginRoute.page, path: Routes.login),
        AutoRoute(page: HomeRoute.page, path: Routes.home),
        RedirectRoute(path: Routes.library, redirectTo: Routes.home),
        AutoRoute(page: WorkDetailsRoute.page, path: Routes.workDetails),
        AutoRoute(page: ReaderRoute.page, path: Routes.reader),
        AutoRoute(page: AboutRoute.page, path: Routes.about),
        AutoRoute(page: HelpRoute.page, path: Routes.help),
        AutoRoute(page: SettingsRoute.page, path: Routes.settings),
      ];
}
