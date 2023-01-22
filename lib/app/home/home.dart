import 'package:flutter/material.dart';

import '../bloc_pattern/bloc_pattern_page.dart';
import '../change_notifier/change_notifier_page.dart';
import '../set_state/set_state_page.dart';
import '../value_notifier/value_notifier_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SetStatePage.route),
              child: const Text('SetState'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ValueNotifierPage.route),
              child: const Text('ValueNotifier'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(ChangeNotifierPage.route),
              child: const Text('ChangeNotifier'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(BlocPatternPage.route),
              child: const Text('Bloc Pattern (Streams)'),
            ),
          ],
        ),
      ),
    );
  }
}
