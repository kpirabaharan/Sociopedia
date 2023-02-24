import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import '../providers/auth.dart';

class PostItem extends StatefulWidget {
  final Post post;

  PostItem(this.post);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Future<void> _likePost() async {
    final id = Provider.of<Auth>(context, listen: false).userId;
    await Provider.of<Posts>(context, listen: false).likePost(widget.post.id, id!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        leading: CircleAvatar(
          backgroundImage:
              NetworkImage('http://localhost:8080/assets/${widget.post.userPicturePath}'),
        ),
        title: Text(
          widget.post.firstName,
          // style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(widget.post.location),
        trailing: IconButton(onPressed: () => {}, icon: Icon(Icons.person_add)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(widget.post.description),
      ),
      if (widget.post.picturePath != null)
        Container(
          padding: EdgeInsets.all(10),
          height: 500,
          width: double.infinity,
          child: Image.network(
            'http://localhost:8080/assets/${widget.post.picturePath}',
            errorBuilder: (context, error, stackTrace) =>
                Center(child: Text('Could not load Image')),
            fit: BoxFit.cover,
          ),
        ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<Auth>(
            builder: (context, user, child) => TextButton.icon(
              onPressed: _likePost,
              icon: Icon(
                Icons.favorite,
                color: widget.post.likes!.containsKey(user.userId)
                    ? Colors.blue.shade400
                    : Colors.white,
              ),
              label: Text(
                '${widget.post.likes?.length ?? '0'}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () => {},
            icon: Icon(
              Icons.comment,
            ),
            label: Text(
              widget.post.comments!.length.toString(),
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
