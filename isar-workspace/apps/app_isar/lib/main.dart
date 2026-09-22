import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';
import 'library_providers.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = IsarWorkRepository();
  await repo.init();
  final auth = DemoAuthService();

  runApp(
    ProviderScope(
      overrides: [workRepoProvider.overrideWithValue(repo)],
      child: IsarApp(repo: repo, auth: auth),
    ),
  );
}

class IsarApp extends StatelessWidget {
  final WorkRepository repo;
  final AuthService auth;
  const IsarApp({super.key, required this.repo, required this.auth});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(
      auth: auth,
      bootstrap: () async {
        await repo.getLibrary();
      },
      isLoggedIn: () => false,
    );
    return MaterialApp.router(
      title: 'architecture-test (isar)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routerConfig: router,
    );
  }
}
