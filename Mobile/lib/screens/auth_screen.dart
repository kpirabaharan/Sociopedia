import 'package:flutter/material.dart';
import 'package:social_media_frontend/widgets/feed.dart';

import '../widgets/image_input.dart';
import '../widgets/auth_form.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen();

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isInit = true;
  AuthMode _authMode = AuthMode.login;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final isRegister = ModalRoute.of(context)!.settings.arguments as bool;
      _authMode = isRegister ? AuthMode.signup : AuthMode.login;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _switchAuth() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
    print(_authMode);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
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
                  child: AuthForm(_authMode),
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
                  // backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
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
                    "or",
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
                onPressed: _switchAuth,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(deviceSize.width * 0.90, 40),
                  // backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text('${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
              ),
              // if (!isRegister)
              //   SizedBox(
              //     height: 200,
              //   )
            ],
          ),
        ],
      ),
    );
  }
}
