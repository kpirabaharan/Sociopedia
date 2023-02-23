import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';

class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    return Text('Check!');
  }
}
