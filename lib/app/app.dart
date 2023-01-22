import 'package:flutter/material.dart';

import 'bloc_pattern/bloc_pattern_page.dart';
import 'change_notifier/change_notifier_page.dart';
import 'home/home.dart';
import 'set_state/set_state_page.dart';
import 'value_notifier/value_notifier_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calc',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      routes: {
        Home.route: (context) => const Home(),
        SetStatePage.route: (context) => const SetStatePage(),
        ValueNotifierPage.route: (context) => const ValueNotifierPage(),
        ChangeNotifierPage.route: (context) => const ChangeNotifierPage(),
        BlocPatternPage.route: (context) => const BlocPatternPage(),
      },
    );
  }
}
