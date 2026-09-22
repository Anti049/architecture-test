import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_drift/database.dart';
import 'package:db_drift/drift_work_repository.dart';
import 'library_cubit.dart';
import 'router.dart';

void main() {
  final db = AppDatabase();
  final repo = DriftWorkRepository(db);
  final auth = DemoAuthService();
  final libraryCubit = LibraryCubit(repo);

  runApp(
    ArchitectureTestApp(
      repo: repo,
      auth: auth,
      libraryCubit: libraryCubit,
    ),
  );
}

class ArchitectureTestApp extends StatelessWidget {
  final WorkRepository repo;
  final AuthService auth;
  final LibraryCubit libraryCubit;
  const ArchitectureTestApp({
    super.key,
    required this.repo,
    required this.auth,
    required this.libraryCubit,
  });

  @override
  Widget build(BuildContext context) {
    final router = buildRouter(
      auth: auth,
      libraryCubit: libraryCubit,
      bootstrap: () async {
        await repo.getLibrary();
      },
      isLoggedIn: () => false,
    );
    return MaterialApp.router(
      title: 'architecture-test (bloc)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      routerConfig: router,
    );
  }
}
