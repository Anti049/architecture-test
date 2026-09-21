import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_drift/database.dart';
import 'package:db_drift/drift_work_repository.dart';
import 'router.dart';
import 'library_providers.dart';

void main() {
  final db = AppDatabase();
  final repo = DriftWorkRepository(db);
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
      title: 'architecture-test (dart_mappable)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      routerConfig: router,
    );
  }
}
