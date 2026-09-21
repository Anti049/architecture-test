import 'package:flutter/material.dart';
import 'package:nav_contract/nav_contract.dart';

class SplashScreen extends StatefulWidget {
  final AppNavigator nav;
  final Future<void> Function() bootstrap; // loads DB items + preferences
  final bool Function() isLoggedIn;
  const SplashScreen({
    super.key,
    required this.nav,
    required this.bootstrap,
    required this.isLoggedIn,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await widget.bootstrap();
    if (!mounted) return;
    widget.isLoggedIn() ? widget.nav.goHome() : widget.nav.goLogin();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('architecture-test')),
        body: const Center(child: CircularProgressIndicator()),
      );
}
