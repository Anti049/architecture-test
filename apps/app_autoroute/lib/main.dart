import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_drift/database.dart';
import 'package:db_drift/drift_work_repository.dart';
import 'app_router.dart';

void main() {
  final db = AppDatabase();
  final repo = DriftWorkRepository(db);
  final auth = DemoAuthService();

  runApp(
    ProviderScope(
      child: ArchitectureTestApp(auth: auth, repo: repo),
    ),
  );
}

class ArchitectureTestApp extends StatelessWidget {
  final AuthService auth;
  final WorkRepository repo;
  ArchitectureTestApp({super.key, required this.auth, required this.repo});

  late final AppRouter _router = AppRouter(auth);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'architecture-test (auto_route)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
        routerConfig: _router.config(),
      );
}
