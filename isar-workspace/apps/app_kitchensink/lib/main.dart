import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';
import 'app_router.dart';
import 'library_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repo = IsarWorkRepository();
  await repo.init();
  final auth = DemoAuthService();
  final libraryCubit = LibraryCubit(repo);
  runApp(KitchenSinkApp(auth: auth, libraryCubit: libraryCubit));
}

class KitchenSinkApp extends StatelessWidget {
  final AuthService auth;
  final LibraryCubit libraryCubit;
  KitchenSinkApp({super.key, required this.auth, required this.libraryCubit});

  late final AppRouter _router = AppRouter(
    auth: auth,
    libraryCubit: libraryCubit,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'architecture-test (kitchensink)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
        routerConfig: _router.config(),
      );
}
