import 'package:flutter/material.dart';

class SimpleScreen extends StatelessWidget {
  final String title;
  const SimpleScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: Text('$title screen')),
      );
}
