import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:core_domain/core_domain.dart';
import 'package:nav_contract/nav_contract.dart';
import 'package:nav_gorouter/go_navigator.dart';
import 'package:feature_splash/splash_screen.dart';
import 'package:feature_auth/login_screen.dart';
import 'package:feature_library/home_shell.dart';
import 'package:feature_library/reader_screen.dart';
import 'package:feature_updates/updates_tab.dart';
import 'package:feature_history/history_tab.dart';
import 'package:feature_browse/browse_tab.dart';
import 'package:feature_more/more_tab.dart';
import 'package:feature_more/simple_screen.dart';
import 'library_cubit.dart';
import 'library_page.dart';

GoRouter buildRouter({
  required AuthService auth,
  required LibraryCubit libraryCubit,
  required Future<void> Function() bootstrap,
  required bool Function() isLoggedIn,
}) {
  late final GoRouter router;
  late final GoNavigator nav;

  router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => SplashScreen(
          nav: nav,
          bootstrap: bootstrap,
          isLoggedIn: isLoggedIn,
        ),
      ),
      GoRoute(
        path: Routes.login,
        builder: (_, __) => LoginScreen(nav: nav, auth: auth),
      ),
      GoRoute(
        path: Routes.library,
        builder: (_, __) => BlocProvider.value(
          value: libraryCubit..load(),
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
        ),
      ),
      GoRoute(
        path: Routes.workDetails,
        builder: (_, state) =>
            SimpleScreen('Work ${state.pathParameters['id']}'),
      ),
      GoRoute(path: Routes.reader, builder: (_, __) => const ReaderScreen()),
      GoRoute(path: Routes.about, builder: (_, __) => const SimpleScreen('About')),
      GoRoute(path: Routes.help, builder: (_, __) => const SimpleScreen('Help')),
      GoRoute(
        path: Routes.settings,
        builder: (_, __) => const SimpleScreen('Settings'),
      ),
    ],
  );

  nav = GoNavigator(router);
  return router;
}
