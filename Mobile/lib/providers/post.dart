import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final String name;
  final String location;
  final String description;
  final String userPicture;
  final String picturePath;
  final int likes;
  final List<String>? comments;

  Post({
    required this.name,
    required this.location,
    required this.description,
    required this.userPicture,
    required this.picturePath,
    this.likes = 0,
    this.comments,
  });
}

class Posts with ChangeNotifier {
  final String? authToken;
  List<Post> _posts = [];

  Posts(this.authToken, this._posts);

  List<Post> get posts {
    return [..._posts];
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse("http://localhost:8080/posts");
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${authToken}'},
    );

    final List<Posts> loadedPosts = [];

    dynamic extractedData = json.decode(response.body);

    print(extractedData);

    if (extractedData == null) return;

    // extractedData.forEach((orderId, orderData) {
    //   loadedOrders.add(
    //     OrderItem(
    //       id: orderId,
    //       amount: orderData['amount'],
    //       products: (orderData['products'] as List<dynamic>)
    //           .map(
    //             (item) => CartItem(
    //                 id: item['id'],
    //                 title: item['title'],
    //                 quantity: item['quantity'],
    //                 price: item['price']),
    //           )
    //           .toList(),
    //       dateTime: DateTime.parse(orderData['dateTime']),
    //     ),
    //   );
    //   _orders = loadedOrders.reversed.toList();
    notifyListeners();
    // });
    // print(json.decode(response.body));
    return;
  }
}
