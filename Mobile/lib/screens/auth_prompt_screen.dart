import 'package:flutter/material.dart';
import 'package:social_media_frontend/screens/auth_screen.dart';

class AuthPromptScreen extends StatelessWidget {
  const AuthPromptScreen({super.key});

  void login(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(AuthScreen.routeName, arguments: false);
  }

  void register(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(AuthScreen.routeName, arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
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
        Center(
          child: Container(
            width: deviceHeight.width * 0.9,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: deviceHeight.width * 0.9,
                    child: Transform.rotate(
                      angle: -2 / 4,
                      child: Center(
                        child: Text(
                          "Sociopedia",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                              fontFamily: 'Lobster',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  Text(
                    'Welcome to Sociopedia\nThe Social Media for Sociopaths!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      // backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => login(context),
                    child: Text('Login'),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.white,
                      side: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    onPressed: () => register(context),
                    child: Text('Sign up'),
                  ),
                  SizedBox(
                    height: 30,
                    width: null,
                  )
                ]),
          ),
        ),
      ]),
    );
  }
}
