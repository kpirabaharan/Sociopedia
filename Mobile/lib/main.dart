import 'package:flutter/material.dart';

import './screens/auth_prompt_screen.dart';
import './screens/auth_screen.dart';
import './screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sociopedia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: Colors.orange),
          fontFamily: 'Rubik',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            titleLarge: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(secondary: Colors.blue),
          fontFamily: 'Rubik',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Rubik'),
            titleLarge: TextStyle(
              color: Colors.white,
            ),
          ),
          canvasColor: Color.fromARGB(255, 48, 48, 48),
        ),
        themeMode: ThemeMode.dark,
        home: AuthPromptScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen()
        });
  }
}
