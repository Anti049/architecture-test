import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_sqflite/sqflite_work_repository.dart';
import 'router.dart';
import 'library_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = SqfliteWorkRepository();
  await repo.init();
  final auth = DemoAuthService();

  runApp(
    ProviderScope(
      overrides: [workRepoProvider.overrideWithValue(repo)],
      child: ArchitectureTestApp(repo: repo, auth: auth),
    ),
  );
}

class ArchitectureTestApp extends StatelessWidget {
  final WorkRepository repo;
  final AuthService auth;
  const ArchitectureTestApp({super.key, required this.repo, required this.auth});

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
      title: 'architecture-test (sqflite)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      routerConfig: router,
    );
  }
}
