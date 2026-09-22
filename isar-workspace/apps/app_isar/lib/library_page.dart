import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:feature_library/library_tab.dart';
import 'package:nav_contract/nav_contract.dart';
import 'library_providers.dart';

class LibraryPage extends ConsumerWidget {
  final AppNavigator nav;
  const LibraryPage(this.nav, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(libraryProvider);
    return async.when(
      data: (works) => LibraryTab(nav: nav, works: works),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
    );
  }
}
