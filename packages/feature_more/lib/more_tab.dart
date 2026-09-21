import 'package:flutter/material.dart';
import 'package:nav_contract/nav_contract.dart';

class MoreTab extends StatelessWidget {
  final AppNavigator nav;
  const MoreTab({super.key, required this.nav});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('More')),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: nav.goAbout,
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Help'),
              onTap: nav.goHelp,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: nav.goSettings,
            ),
          ],
        ),
      );
}
