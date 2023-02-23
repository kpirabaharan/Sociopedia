import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import './post_item.dart';

class Feed extends StatelessWidget {
  Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).posts;
    print(posts);
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: posts[i],
              child: PostItem(),
            ));
  }
}
