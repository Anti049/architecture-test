import 'package:flutter/material.dart';

class UpdatesTab extends StatelessWidget {
  const UpdatesTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Updates')),
        body: const Center(child: Text('Recent updates')),
      );
}
