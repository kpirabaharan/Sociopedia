import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

//TODO: Add AutoLogout after 1hr

class User {
  final String _id;
  final String firstName;
  final String lastName;
  final List<dynamic> friends;
  final String email;
  final String picturePath;
  final String location;
  final String occupation;
  final int viewedProfile;
  final int impressions;

  User(
    this._id, {
    required this.firstName,
    required this.lastName,
    required this.friends,
    required this.email,
    required this.picturePath,
    required this.location,
    required this.occupation,
    this.viewedProfile = 0,
    this.impressions = 0,
  });
}

class Auth with ChangeNotifier {
  late User _user;
  String? _token;

  String? get token {
    if (_token != null) {
      return _token as String;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _user._id;
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 400) {
        throw HttpException(responseData['msg']);
      }

      _user = User(
        responseData['user']['_id'],
        firstName: responseData['user']['firstName'],
        lastName: responseData['user']['lastName'],
        friends: responseData['user']['friends'],
        email: responseData['user']['email'],
        picturePath: responseData['user']['picturePath'],
        location: responseData['user']['location'],
        occupation: responseData['user']['occupation'],
        viewedProfile: responseData['user']['viewedProfile'],
        impressions: responseData['user']['impressions'],
      );
      _token = responseData['token'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          '_id': _user._id,
          'firstName': _user.firstName,
          'lastName': _user.lastName,
          'friends': _user.friends,
          'email': _user.email,
          'picturePath': _user.picturePath,
          'location': _user.location,
          'occupation': _user.occupation,
          'viewedProfile': _user.viewedProfile,
          'impressions': _user.impressions,
        },
      );
      prefs.setString('userData', userData);
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData') as String) as Map<String, dynamic>;

    _token = extractedUserData['token'] as String;
    _user = User(
      extractedUserData['_id'],
      firstName: extractedUserData['firstName'],
      lastName: extractedUserData['lastName'],
      friends: extractedUserData['friends'],
      email: extractedUserData['email'],
      picturePath: extractedUserData['picturePath'],
      location: extractedUserData['location'],
      occupation: extractedUserData['occupation'],
      viewedProfile: extractedUserData['viewedProfile'],
      impressions: extractedUserData['impressions'],
    );
    notifyListeners();
    return true;
  }
}
