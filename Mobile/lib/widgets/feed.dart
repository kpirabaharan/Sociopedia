import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import './post_item.dart';

class Feed extends StatefulWidget {
  final String userId;
  const Feed({required this.userId, super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late Future _postsFuture;

  Future _obtainPostsFuture() async {
    try {
      await Provider.of<Posts>(context, listen: false).fetchPosts(userId: widget.userId);
    } catch (err) {
      //TODO: Try to make this fail and check how it fails
      print(err);
    }
  }

  @override
  void initState() {
    _postsFuture = _obtainPostsFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _postsFuture,
      builder: ((ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.error != null) {
            // Do Error Handling Here
            return Center(child: Text('An Error Occured!'));
          } else {
            return Consumer<Posts>(
              builder: (ctx, postData, child) => ListView.builder(
                itemCount: postData.posts.length,
                itemBuilder: (ctx, i) => PostItem(postData.posts[i]),
              ),
            );
          }
        }
      }),
    );
  }
}
