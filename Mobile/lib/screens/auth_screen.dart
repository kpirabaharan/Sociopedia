import 'dart:io' show Platform, File;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';
import '../widgets/auth_form.dart';

enum AuthMode { signup, login }

var isLoading = false;

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  var _isInit = true;
  var isRegister = false;
  void didChangeDependencies() {
    if (_isInit) {
      isRegister = ModalRoute.of(context)!.settings.arguments as bool;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> login(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(email, password);
      Navigator.of(context).pop();
    } on HttpException catch (err) {
      var errorMessage = 'Authentication failed';
      if (err.toString().contains('User does not exist')) {
        errorMessage = 'Invalid email.';
      } else if (err.toString().contains('Invalid credentials')) {
        errorMessage = 'Invalid password.';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later.';
      showErrorDialog(errorMessage);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> register(String firstName, String lastName, String location, String occupation,
      File picture, String picturePath, String email, String password) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).register(
          firstName, lastName, location, occupation, picture, picturePath, email, password);
    } catch (error) {
      const errorMessage = 'Could not register you. Please try again later.';
      showErrorDialog(errorMessage);
    } finally {
      setState(() {
        isLoading = false;
        isRegister = false;
      });
    }
  }

  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
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
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: deviceSize.width * 0.90,
                        child: AuthForm(isRegister, login, register),
                      ),
                    ),
                  ],
                ),
          Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: IconButton(
                  icon: Platform.isIOS ? Icon(Icons.arrow_back_ios) : Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
