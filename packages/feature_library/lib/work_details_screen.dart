import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:nav_contract/nav_contract.dart';

class WorkDetailsScreen extends StatelessWidget {
  final AppNavigator nav;
  final Work work;
  const WorkDetailsScreen({super.key, required this.nav, required this.work});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(work.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => nav.goReader(workId: work.id),
          child: const Icon(Icons.play_arrow),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(work.description),
            const SizedBox(height: 16),
            ...work.chapters.map(
              (c) => ListTile(title: Text('Ch ${c.number}: ${c.name}')),
            ),
          ],
        ),
      );
}
