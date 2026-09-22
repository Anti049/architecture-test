import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:db_isar/isar_work_repository.dart';
import 'app_router.dart';
import 'library_cubit.dart';
import 'mappable_work_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final baseRepo = IsarWorkRepository();
  await baseRepo.init();
  final repo = MappableWorkRepository(baseRepo);
  final auth = DemoAuthService();
  final libraryCubit = LibraryCubit(repo);
  runApp(IsarComboApp(auth: auth, libraryCubit: libraryCubit));
}

class IsarComboApp extends StatelessWidget {
  final AuthService auth;
  final LibraryCubit libraryCubit;
  IsarComboApp({super.key, required this.auth, required this.libraryCubit});

  late final AppRouter _router = AppRouter(
    auth: auth,
    libraryCubit: libraryCubit,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'architecture-test (isar+bloc+mappable+autoroute)',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
        routerConfig: _router.config(),
      );
}
