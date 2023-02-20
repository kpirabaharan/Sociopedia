import 'package:flutter/material.dart';

import '../widgets/form.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 4, 40, 0.5),
                  Color.fromRGBO(0, 78, 146, 1),
                  Color.fromRGBO(0, 4, 40, 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.5, 1],
              ),
            ),
          ),
          Column(children: [
            SizedBox(
              height: deviceHeight.height * 0.1,
            ),
            Center(
                child: Container(
              width: deviceHeight.width * 0.9,
              child: const AuthForm(),
            )),
          ]),
        ],
      ),
    );
  }
}
