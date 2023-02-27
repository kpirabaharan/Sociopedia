import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../screens/auth_screen.dart';

//TODO: Add FocusNodes to TextForms
class AuthForm extends StatefulWidget {
  final bool isRegister;
  final void Function(String email, String password) loginFn;
  final void Function(String firstName, String lastName, String location, String occupation,
      File picture, String picturePath, String email, String password) registerFn;

  const AuthForm(this.isRegister, this.loginFn, this.registerFn, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isInit = true;
  AuthMode _authMode = AuthMode.login;
  final _formKey = GlobalKey<FormState>();

  File? _storedImage;

  final Map<String, String> _authData = {
    'firstName': '',
    'lastName': '',
    'location': '',
    'occupation': '',
    'picturePath': '',
    'email': '',
    'password': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _authMode = widget.isRegister ? AuthMode.signup : AuthMode.login;
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
  }

  void _tryLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    widget.loginFn(_authData['email']!, _authData['password']!);
  }

  Future<void> _selectPicture() async {
    final picker = ImagePicker();
    XFile? pickedXFile;

    pickedXFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
    );

    if (pickedXFile == null) {
      return;
    }

    final imageFile = File(pickedXFile.path);

    setState(() {
      _storedImage = imageFile;
    });

    _authData['picturePath'] = path.basename(imageFile.path);
  }

  void _tryRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_storedImage == null) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _authMode = AuthMode.login;
    });
    widget.registerFn(
        _authData['firstName']!,
        _authData['lastName']!,
        _authData['location']!,
        _authData['occupation']!,
        _storedImage as File,
        _authData['picturePath']!,
        _authData['email']!,
        _authData['password']!);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: deviceSize.height * 0.1,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            // height: _heightAnimation.value.height,
            constraints: BoxConstraints(maxHeight: deviceSize.height * 0.8),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (_authMode == AuthMode.signup)
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
                    if (_authMode == AuthMode.signup)
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
                    if (_authMode == AuthMode.signup)
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
                    if (_authMode == AuthMode.signup)
                      Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    if (_authMode == AuthMode.signup)
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1), color: Colors.grey),
                            alignment: Alignment.center,
                            child: _storedImage != null
                                ? Image.file(_storedImage as File,
                                    fit: BoxFit.cover, width: double.infinity)
                                : const Text('No Image Taken', textAlign: TextAlign.center),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => {},
                                    icon: Icon(Icons.camera),
                                    label: Text('Take Picture'),
                                  ),
                                  TextButton.icon(
                                    onPressed: _selectPicture,
                                    icon: Icon(Icons.photo_size_select_actual_rounded),
                                    label: Text('Choose'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    ElevatedButton(
                      onPressed: _authMode == AuthMode.login ? _tryLogin : _tryRegister,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        minimumSize: Size(deviceSize.width * 0.90, 40),
                        // backgroundColor: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
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
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
