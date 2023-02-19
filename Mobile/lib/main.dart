import 'package:flutter/material.dart';

import './screens/auth_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Sociopedia', home: const AuthScreen(), routes: {
      HomeScreen.routeName: (ctx) => const HomeScreen(),
    });
  }
}
