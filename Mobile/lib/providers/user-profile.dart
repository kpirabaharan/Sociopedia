import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './user.dart';

class UserProfile with ChangeNotifier {
  late User? _user;
  String? _token;

  UserProfile(this._token, this._user);

  User? get user {
    return _user;
  }
}
