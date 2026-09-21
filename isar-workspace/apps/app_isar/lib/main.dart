import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';

void main() {
  runApp(const ProviderScope(child: IsarApp()));
}

class IsarApp extends StatelessWidget {
  const IsarApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'architecture-test (isar)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
        home: const _Boot(),
      );
}

/// Minimal boot that initialises Isar then shows the library.
/// (Full routing mirrors app_baseline/router.dart; kept short here since the
/// Isar workspace is isolated and only needs to prove the DB swap compiles.)
class _Boot extends StatefulWidget {
  const _Boot();
  @override
  State<_Boot> createState() => _BootState();
}

class _BootState extends State<_Boot> {
  final repo = IsarWorkRepository();
  List<Work> works = const [];
  bool ready = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await repo.init();
    works = await repo.getLibrary();
    if (mounted) setState(() => ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!ready) {
      return Scaffold(
        appBar: AppBar(title: const Text('architecture-test')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Library (Isar)')),
      body: ListView(
        children: [for (final w in works) ListTile(title: Text(w.title))],
      ),
    );
  }
}
