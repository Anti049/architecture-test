import 'package:flutter/material.dart';
import 'package:core_domain/core_domain.dart';
import 'package:nav_contract/nav_contract.dart';

class LoginScreen extends StatefulWidget {
  final AppNavigator nav;
  final AuthService auth;
  const LoginScreen({super.key, required this.nav, required this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  String? _error;

  Future<void> _login() async {
    try {
      await widget.auth.login(username: _user.text, password: _pass.text);
      if (mounted) widget.nav.goHome();
    } catch (_) {
      setState(() => _error = 'Invalid credentials');
    }
  }

  Future<void> _anon() async {
    await widget.auth.continueAnonymously();
    if (mounted) widget.nav.goHome();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Login / Register')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _user,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _pass,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              FilledButton(onPressed: _login, child: const Text('Login')),
              TextButton(
                onPressed: _anon,
                child: const Text('Continue anonymously'),
              ),
            ],
          ),
        ),
      );
}
