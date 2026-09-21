abstract interface class AppNavigator {
  void goSplash();
  void goLogin();
  void goHome();
  void goLibrary();
  void goWorkDetails(String workId);
  void goReader({String? workId, String? chapterId});
  void goAbout();
  void goHelp();
  void goSettings();
  void back();
}

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const library = '/home/library';
  static const updates = '/home/updates';
  static const history = '/home/history';
  static const browse = '/home/browse';
  static const more = '/home/more';
  static const workDetails = '/home/library/work/:id';
  static const reader = '/reader';
  static const about = '/home/more/about';
  static const help = '/home/more/help';
  static const settings = '/home/more/settings';
}
