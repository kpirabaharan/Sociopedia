import 'package:flutter/material.dart';

import '../providers/post.dart';
import 'package:http/http.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Text('Check!');
  }
}
