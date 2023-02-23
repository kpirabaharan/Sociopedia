import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post with ChangeNotifier {
  final String _id;
  final String userId;
  // final String firstName;
  // final String lastName;
  // final String location;
  // final String description;
  // final String userPicturePath;
  // final String picturePath;
  // final Map<String, bool>? likes;
  // final List<String>? comments;

  Post(
    this._id, {
    required this.userId,
    // required this.firstName,
    // required this.lastName,
    // required this.location,
    // required this.description,
    // required this.picturePath,
    // required this.userPicturePath,
    // this.likes,
    // this.comments,
  });
}

class Posts with ChangeNotifier {
  final String? _token;
  List<Post> _posts;

  Posts(this._token, this._posts);

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> fetchPosts() async {
    try {
      final url = Uri.parse("http://localhost:8080/posts");
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );

      List<Post> loadedPosts = [];

      dynamic extractedData = json.decode(response.body) as List<dynamic>;

      if (extractedData == null) return;

      for (var post in extractedData) {
        loadedPosts.add(Post(
          post['_id']!,
          userId: post['userId']!,
          // firstName: post['firstName']!,
          // lastName: post['lastName']!,
          // location: post['location']!,
          // description: post['description']!,
          // picturePath: post['picturePath']!,
          // userPicturePath: post['userPicturePath'],
        ));
      }

      _posts = loadedPosts;

      notifyListeners();
    } catch (err) {
      print('err: $err');
    }
  }
}
