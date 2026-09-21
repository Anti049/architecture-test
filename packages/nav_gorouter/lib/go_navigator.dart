import 'package:go_router/go_router.dart';
import 'package:nav_contract/nav_contract.dart';

class GoNavigator implements AppNavigator {
  final GoRouter router;
  GoNavigator(this.router);
  @override
  void goSplash() => router.go(Routes.splash);
  @override
  void goLogin() => router.go(Routes.login);
  @override
  void goHome() => router.go(Routes.library);
  @override
  void goLibrary() => router.go(Routes.library);
  @override
  void goWorkDetails(String id) => router.go('/home/library/work/$id');
  @override
  void goReader({String? workId, String? chapterId}) => router.go(Routes.reader);
  @override
  void goAbout() => router.go(Routes.about);
  @override
  void goHelp() => router.go(Routes.help);
  @override
  void goSettings() => router.go(Routes.settings);
  @override
  void back() => router.pop();
}
