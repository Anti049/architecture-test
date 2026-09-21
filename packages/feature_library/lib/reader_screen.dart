import 'package:flutter/material.dart';

class ReaderScreen extends StatelessWidget {
  final String? workId;
  const ReaderScreen({super.key, this.workId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(workId == null ? 'Reader' : 'Reader ($workId)')),
        body: const Center(child: Text('Reader content')),
      );
}
