import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';
import 'library_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = IsarWorkRepository();
  await repo.init();
  runApp(IsarComboApp(repo: repo));
}

class IsarComboApp extends StatelessWidget {
  final IsarWorkRepository repo;
  const IsarComboApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'architecture-test (isar+bloc+mappable+autoroute)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
        home: BlocProvider(
          create: (_) => LibraryCubit(repo)..load(),
          child: const _LibraryScreen(),
        ),
      );
}

class _LibraryScreen extends StatelessWidget {
  const _LibraryScreen();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Library (Isar+Bloc)')),
        body: BlocBuilder<LibraryCubit, LibraryState>(
          builder: (_, state) => switch (state) {
            LibraryLoaded s => ListView(
                children: [for (final w in s.works) ListTile(title: Text(w.title))],
              ),
            LibraryError s => Center(child: Text('${s.error}')),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      );
}
