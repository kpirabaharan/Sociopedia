import 'package:flutter/material.dart';

import '../providers/post.dart';
import 'package:http/http.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    print(post.picturePath);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage('http://localhost:8080/assets/${post.userPicturePath}'),
        ),
        title: Text(
          post.firstName,
          // style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(post.location),
        trailing: IconButton(onPressed: () => {}, icon: Icon(Icons.person_add)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(post.description),
      ),
      if (post.picturePath != null)
        Container(
          padding: EdgeInsets.all(10),
          height: 500,
          width: double.infinity,
          child: Image.network(
            'http://localhost:8080/assets/${post.picturePath}',
            errorBuilder: (context, error, stackTrace) =>
                Center(child: Text('Could not load Image')),
            fit: BoxFit.cover,
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => {},
            icon: Icon(Icons.favorite),
            label: Text('${post.likes?.length ?? '0'}'),
          ),
          TextButton.icon(
            onPressed: () => {},
            icon: Icon(
              Icons.comment,
              color: Colors.white,
            ),
            label: Text(
              post.comments!.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => {},
          ),
        ],
      ),
      Divider(
        thickness: 2,
      ),
    ]);
  }
}
