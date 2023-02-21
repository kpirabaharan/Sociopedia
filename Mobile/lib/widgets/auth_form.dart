import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_frontend/screens/auth_screen.dart';

import './image_input.dart';

class AuthForm extends StatefulWidget {
  final AuthMode _authMode;

  const AuthForm(this._authMode, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final GlobalKey<FormState> _formKey = GlobalKey();
    final Map<String, String> _authData = {
      'email': '',
      'password': '',
    };

    File? _pickedImage;
    void _selectImage(File pickedImage) {
      _pickedImage = pickedImage;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(maxHeight: deviceSize.height * 0.6),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (widget._authMode == AuthMode.signup)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: Theme.of(context).textTheme.labelMedium,
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['firstName'] = value!;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: Theme.of(context).textTheme.labelMedium,
                              suffixIcon: Icon(Icons.person),
                              suffixIconColor: Theme.of(context).iconTheme.color,
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Invalid Name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['lastName'] = value!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                if (widget._authMode == AuthMode.signup)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      suffixIcon: Icon(
                        Icons.location_on,
                      ),
                      suffixIconColor: Theme.of(context).iconTheme.color,
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid Location';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['location'] = value!;
                    },
                  ),
                if (widget._authMode == AuthMode.signup)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Occupation',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                      suffixIcon: Icon(Icons.work),
                      suffixIconColor: Theme.of(context).iconTheme.color,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Invalid Occupation';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['occupation'] = value!;
                    },
                  ),
                if (widget._authMode == AuthMode.signup)
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                if (widget._authMode == AuthMode.signup) ImageInput(_selectImage),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    suffixIcon: Icon(Icons.email),
                    suffixIconColor: Theme.of(context).iconTheme.color,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    suffixIcon: Icon(Icons.lock),
                    suffixIconColor: Theme.of(context).iconTheme.color,
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid password!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
