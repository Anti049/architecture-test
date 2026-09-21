import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'demo_credentials.dart';

class DemoAuthService implements AuthService {
  @override
  Future<AppUser> login({required String username, required String password}) async {
    if (username == DemoCredentials.username && password == DemoCredentials.password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('displayName', DemoCredentials.displayName);
      return const AppUser(
        username: DemoCredentials.username,
        displayName: DemoCredentials.displayName,
        isAnonymous: false,
      );
    }
    throw Exception('Invalid credentials');
  }

  @override
  Future<AppUser> continueAnonymously() async =>
      const AppUser(displayName: 'Guest', isAnonymous: true);

  @override
  Future<AppUser?> currentUser() async => null;

  @override
  Future<void> logout() async {}
}
