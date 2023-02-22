import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_frontend/screens/home_screen.dart';

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
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isRegister = ModalRoute.of(context)!.settings.arguments;

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
                        child: AuthForm(isRegister as bool, login),
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
