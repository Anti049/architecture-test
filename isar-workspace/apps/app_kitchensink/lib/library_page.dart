import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feature_library/library_tab.dart';
import 'package:nav_contract/nav_contract.dart';
import 'library_cubit.dart';

class LibraryPage extends StatelessWidget {
  final AppNavigator nav;
  const LibraryPage(this.nav, {super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LibraryCubit, LibraryState>(
        builder: (_, state) => switch (state) {
          LibraryLoaded s => LibraryTab(nav: nav, works: s.works),
          LibraryError s => Center(child: Text('${s.error}')),
          _ => const Center(child: CircularProgressIndicator()),
        },
      );
}
