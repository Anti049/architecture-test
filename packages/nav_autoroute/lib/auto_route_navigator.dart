import 'package:auto_route/auto_route.dart';
import 'package:nav_contract/nav_contract.dart';

/// Thin AppNavigator adapter over an AutoRoute [StackRouter].
/// The concrete AppRouter (with @RoutePage screens + app_router.gr.dart) is
/// generated inside each app that opts into AutoRoute.
class AppAutoRouteNavigator implements AppNavigator {
  final StackRouter router;
  AppAutoRouteNavigator(this.router);

  @override
  void goSplash() => router.replacePath(Routes.splash);
  @override
  void goLogin() => router.replacePath(Routes.login);
  @override
  void goHome() => router.replacePath(Routes.home);
  @override
  void goLibrary() => router.replacePath(Routes.library);
  @override
  void goWorkDetails(String id) => router.pushPath('/home/library/work/$id');
  @override
  void goReader({String? workId, String? chapterId}) =>
      router.pushPath(Routes.reader);
  @override
  void goAbout() => router.pushPath(Routes.about);
  @override
  void goHelp() => router.pushPath(Routes.help);
  @override
  void goSettings() => router.pushPath(Routes.settings);
  @override
  void back() => router.maybePop();
}
