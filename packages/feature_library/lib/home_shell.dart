import 'package:flutter/material.dart';
import 'package:nav_contract/nav_contract.dart';

/// Home scaffold with the 5-tab bottom navigation bar.
/// Tabs are injected so each app can wire in its state-managed feature widgets.
class HomeShell extends StatefulWidget {
  final AppNavigator nav;
  final List<Widget> tabs; // [Library, Updates, History, Browse, More]
  const HomeShell({super.key, required this.nav, required this.tabs});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: _index, children: widget.tabs),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.collections_bookmark),
              label: 'Library',
            ),
            NavigationDestination(icon: Icon(Icons.update), label: 'Updates'),
            NavigationDestination(icon: Icon(Icons.history), label: 'History'),
            NavigationDestination(icon: Icon(Icons.explore), label: 'Browse'),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'More'),
          ],
        ),
      );
}
