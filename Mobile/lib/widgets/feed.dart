import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import './post_item.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late Future _postsFuture;

  Future _obtainPostsFuture() {
    return Provider.of<Posts>(context, listen: false).fetchPosts();
  }

  @override
  void initState() {
    _postsFuture = _obtainPostsFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DUMMY_DATA = [
      Post(
          name: 'Keeshigan',
          location: 'Ajax',
          description: 'Selfie',
          userPicture: 'Alex.jpeg',
          picturePath: 'Alex.jpeg',
          likes: 3,
          comments: ['a', 'b'])
    ];
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
