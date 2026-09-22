import 'package:auto_route/auto_route.dart';
import 'package:nav_contract/nav_contract.dart';

class LocalAutoRouteNavigator implements AppNavigator {
  final StackRouter router;
  LocalAutoRouteNavigator(this.router);

  @override
  void goSplash() => router.replaceNamed(Routes.splash);

  @override
  void goLogin() => router.replaceNamed(Routes.login);

  @override
  void goHome() => router.replaceNamed(Routes.library);

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
