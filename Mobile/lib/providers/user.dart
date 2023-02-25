import 'package:flutter/material.dart';

class Friend {
  final String id;
  final String firstName;
  final String lastName;
  final String picturePath;
  final String location;
  final String occupation;

  Friend({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.picturePath,
    required this.location,
    required this.occupation,
  });
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final List<Friend> friends;
  final String email;
  final String picturePath;
  final String location;
  final String occupation;
  final int viewedProfile;
  final int impressions;

  User({
    required this.id,
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
