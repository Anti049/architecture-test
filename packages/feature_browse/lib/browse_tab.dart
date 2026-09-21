import 'package:flutter/material.dart';

/// Browse tab with top swipe tabs (Sources / Extensions / Search).
/// The AppBar title AND actions change depending on the active sub-tab.
class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tc = TabController(length: 3, vsync: this)
    ..addListener(() => setState(() {}));

  static const _titles = ['Sources', 'Extensions', 'Search'];

  List<Widget> _actionsFor(int i) => switch (i) {
        0 => [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})],
        1 => [IconButton(icon: const Icon(Icons.refresh), onPressed: () {})],
        _ => [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      };

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_titles[_tc.index]),
          actions: _actionsFor(_tc.index),
          bottom: TabBar(
            controller: _tc,
            tabs: const [
              Tab(text: 'Sources'),
              Tab(text: 'Extensions'),
              Tab(text: 'Search'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tc,
          children: const [
            Center(child: Text('Sources')),
            Center(child: Text('Extensions')),
            Center(child: Text('Search')),
          ],
        ),
      );
}
