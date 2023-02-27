import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import './user.dart';

//TODO: Add AutoLogout after 1hr

class Auth with ChangeNotifier {
  late User? _user;
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
    return _user!.id;
  }

  List<String> get friends {
    List<String> friendIds = [];

    for (var friend in _user!.friends) {
      friendIds.add(friend.id);
    }
    return friendIds;
  }

  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse('http://localhost:8080/auth/login');
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
        id: responseData['user']['_id'],
        firstName: responseData['user']['firstName'],
        lastName: responseData['user']['lastName'],
        friends: (responseData['user']['friends'] as List)
            .map(
              (friend) => Friend(
                id: friend['_id'],
                firstName: friend['firstName'],
                lastName: friend['lastName'],
                picturePath: friend['picturePath'],
                location: friend['location'],
                occupation: friend['occupation'],
              ),
            )
            .toList(),
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
          '_id': responseData['user']['_id'],
          'firstName': responseData['user']['firstName'],
          'lastName': responseData['user']['lastName'],
          'friends': responseData['user']['friends'],
          'email': responseData['user']['email'],
          'picturePath': responseData['user']['picturePath'],
          'location': responseData['user']['location'],
          'occupation': responseData['user']['occupation'],
          'viewedProfile': responseData['user']['viewedProfile'],
          'impressions': responseData['user']['impressions'],
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
      id: extractedUserData['_id'],
      firstName: extractedUserData['firstName'],
      lastName: extractedUserData['lastName'],
      friends: (extractedUserData['friends'] as List)
          .map(
            (friend) => Friend(
              id: friend['_id'],
              firstName: friend['firstName'],
              lastName: friend['lastName'],
              picturePath: friend['picturePath'],
              location: friend['location'],
              occupation: friend['occupation'],
            ),
          )
          .toList(),
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

  Future<void> logout() async {
    _token = null;
    _user = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> getFriends(String id) async {
    try {
      final url = Uri.parse('http://localhost:8080/users/$id/friends');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );

      List<Friend> _loadedFriends = [];

      final responseData = json.decode(response.body);

      _loadedFriends = (responseData as List)
          .map(
            (friend) => Friend(
              id: friend['_id'],
              firstName: friend['firstName'],
              lastName: friend['lastName'],
              picturePath: friend['picturePath'],
              location: friend['location'],
              occupation: friend['occupation'],
            ),
          )
          .toList();

      final _oldUser = _user;

      _user = User(
        id: _oldUser!.id,
        firstName: _oldUser.firstName,
        lastName: _oldUser.lastName,
        friends: _loadedFriends,
        email: _oldUser.email,
        picturePath: _oldUser.picturePath,
        location: _oldUser.location,
        occupation: _oldUser.occupation,
      );

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> patchFriend(String id, String friendId) async {
    try {
      final url = Uri.parse('http://localhost:8080/users/$id/$friendId');

      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      List<Friend> _loadedFriends = [];

      final responseData = json.decode(response.body);

      _loadedFriends = (responseData as List)
          .map(
            (friend) => Friend(
              id: friend['_id'],
              firstName: friend['firstName'],
              lastName: friend['lastName'],
              picturePath: friend['picturePath'],
              location: friend['location'],
              occupation: friend['occupation'],
            ),
          )
          .toList();

      final _oldUser = _user;

      _user = User(
        id: _oldUser!.id,
        firstName: _oldUser.firstName,
        lastName: _oldUser.lastName,
        friends: _loadedFriends,
        email: _oldUser.email,
        picturePath: _oldUser.picturePath,
        location: _oldUser.location,
        occupation: _oldUser.occupation,
      );

      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
