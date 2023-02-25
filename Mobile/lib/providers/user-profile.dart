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

  Future<void> fetchUser(String userId) async {
    try {
      final url = Uri.parse('http://localhost:8080/users/$userId');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );

      final responseData = json.decode(response.body);

      print(responseData);

      _user = User(
        id: responseData['_id'],
        firstName: responseData['firstName'],
        lastName: responseData['lastName'],
        friends: (responseData['friends'] as List)
            .map((friend) => Friend(
                  id: friend['_id'],
                  firstName: friend['firstName'],
                  lastName: friend['lastName'],
                  picturePath: friend['picturePath'],
                  location: friend['location'],
                  occupation: friend['occupation'],
                ))
            .toList(),
        email: responseData['email'],
        picturePath: responseData['picturePath'],
        location: responseData['location'],
        occupation: responseData['occupation'],
        viewedProfile: responseData['viewedProfile'],
        impressions: responseData['impressions'],
      );
    } catch (err) {
      rethrow;
    }
  }
}
