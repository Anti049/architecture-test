import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:nav_contract/nav_contract.dart';

class LibraryTab extends StatelessWidget {
  final AppNavigator nav;
  final List<Work> works; // provided by the app's state layer (Riverpod/Bloc)
  const LibraryTab({super.key, required this.nav, required this.works});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Library')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => nav.goReader(),
          child: const Icon(Icons.menu_book),
        ),
        body: ListView.builder(
          itemCount: works.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(works[i].title),
            subtitle: Text(works[i].author),
            onTap: () => nav.goWorkDetails(works[i].id),
          ),
        ),
      );
}
