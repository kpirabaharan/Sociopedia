import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import '../providers/auth.dart';
import '../screens/profile_page_screen.dart';

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

  void _goToProfile() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ProfilePage(widget.post.id, false)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        leading: GestureDetector(
          onTap: _goToProfile,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'http://localhost:8080/assets/${widget.post.userPicturePath}',
            ),
          ),
        ),
        title: GestureDetector(
          onTap: _goToProfile,
          child: Text(
            widget.post.firstName,
            // style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        subtitle: Text(widget.post.location),
        trailing: IconButton(
          onPressed: () => {},
          icon: Icon(Icons.person_add),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Text(widget.post.description),
      ),
      Stack(alignment: AlignmentDirectional.bottomStart, children: [
        if (widget.post.picturePath != null)
          Container(
            padding: EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'http://localhost:8080/assets/${widget.post.picturePath}',
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Text('Could not load Image')),
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (widget.post.picturePath != null)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
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
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
      ]),
      if (widget.post.picturePath == null)
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 15, 0),
          child: Row(
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
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => {},
              ),
            ],
          ),
        ),
      Divider(
        thickness: 2,
      ),
    ]);
  }
}
