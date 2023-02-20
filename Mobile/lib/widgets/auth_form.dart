import 'dart:io';

import 'package:flutter/material.dart';

import './image_input.dart';

class AuthForm extends StatefulWidget {
  final bool isRegister;

  const AuthForm(this.isRegister, {super.key});

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
                if (widget.isRegister)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'First Name',
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
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              suffixIcon: Icon(Icons.person),
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
                if (widget.isRegister)
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Location', suffixIcon: Icon(Icons.location_on)),
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
                if (widget.isRegister)
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Occupation', suffixIcon: Icon(Icons.work)),
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
                if (widget.isRegister) Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                if (widget.isRegister) ImageInput(_selectImage),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    suffixIcon: Icon(Icons.email),
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
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.lock),
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
