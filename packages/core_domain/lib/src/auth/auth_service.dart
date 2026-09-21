class AppUser {
  final String? username;
  final String displayName;
  final bool isAnonymous;
  const AppUser({this.username, required this.displayName, required this.isAnonymous});
}

abstract interface class AuthService {
  Future<AppUser?> currentUser();
  Future<AppUser> login({required String username, required String password});
  Future<AppUser> continueAnonymously();
  Future<void> logout();
}

abstract interface class AppPreferences {
  Future<bool> seenOnboarding();
  Future<void> setSeenOnboarding(bool value);
}
