import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';
import 'library_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = IsarWorkRepository();
  await repo.init();
  runApp(KitchenSinkApp(repo: repo));
}

class KitchenSinkApp extends StatelessWidget {
  final IsarWorkRepository repo;
  const KitchenSinkApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'architecture-test (kitchensink)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
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
        appBar: AppBar(title: const Text('Library (Kitchen Sink)')),
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
