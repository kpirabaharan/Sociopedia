import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 4, 40, 0.5),
                  Color.fromRGBO(0, 78, 146, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
