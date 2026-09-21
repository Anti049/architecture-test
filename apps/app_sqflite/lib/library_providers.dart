import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core_domain/core_domain.dart';

final workRepoProvider = Provider<WorkRepository>(
  (ref) => throw UnimplementedError('workRepoProvider must be overridden'),
);

final libraryProvider = FutureProvider<List<Work>>(
  (ref) => ref.watch(workRepoProvider).getLibrary(),
);
