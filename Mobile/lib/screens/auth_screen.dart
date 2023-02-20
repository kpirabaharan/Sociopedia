import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({super.key});

  void switchAuth(BuildContext ctx, bool isRegister) {
    Navigator.of(ctx).pushReplacementNamed(AuthScreen.routeName, arguments: !isRegister);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isRegister = ModalRoute.of(context)!.settings.arguments as bool;
    final authText = isRegister ? 'Register' : 'Login';
    final notAuthText = isRegister ? 'Login' : 'Register';

    return Scaffold(
      appBar: AppBar(
        title: Text(authText),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: deviceSize.width * 0.90,
                  child: AuthForm(isRegister),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(deviceSize.width * 0.90, 40),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(authText),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      indent: deviceSize.width * 0.05,
                      endIndent: deviceSize.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      indent: deviceSize.width * 0.05,
                      endIndent: deviceSize.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              ElevatedButton(
                onPressed: () => switchAuth(context, isRegister),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(deviceSize.width * 0.90, 40),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(notAuthText),
              ),
              if (!isRegister)
                SizedBox(
                  height: 200,
                )
            ],
          ),
        ],
      ),
    );
  }
}
