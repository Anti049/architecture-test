import 'package:auto_route/auto_route.dart';
import 'package:nav_contract/nav_contract.dart';

/// Thin AppNavigator adapter over an AutoRoute [StackRouter].
/// The concrete AppRouter (with @RoutePage screens + app_router.gr.dart) is
/// generated inside each app that opts into AutoRoute.
class AutoRouteNavigator implements AppNavigator {
  final StackRouter router;
  AutoRouteNavigator(this.router);

  @override
  void goSplash() => router.replaceNamed(Routes.splash);
  @override
  void goLogin() => router.replaceNamed(Routes.login);
  @override
  void goHome() => router.replaceNamed(Routes.home);
  @override
  void goLibrary() => router.replaceNamed(Routes.library);
  @override
  void goWorkDetails(String id) => router.pushNamed('/home/library/work/$id');
  @override
  void goReader({String? workId, String? chapterId}) =>
      router.pushNamed(Routes.reader);
  @override
  void goAbout() => router.pushNamed(Routes.about);
  @override
  void goHelp() => router.pushNamed(Routes.help);
  @override
  void goSettings() => router.pushNamed(Routes.settings);
  @override
  void back() => router.maybePop();
}
