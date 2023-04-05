import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';
import '../providers/auth.dart';
import '../widgets/friend.dart';
import '../screens/profile_page_screen.dart';

class PostItem extends StatefulWidget {
  final Post post;

  const PostItem({required this.post, required Key key}) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  var _isComments = false;

  Future<void> _likePost() async {
    final id = Provider.of<Auth>(context, listen: false).userId;
    await Provider.of<Posts>(context, listen: false).likePost(widget.post.id, id!);
  }

  void _goToProfile() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ProfilePage(widget.post.userId, false)));
  }

  void _toggleComments() {
    setState(() {
      _isComments = !_isComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FriendListTile(
        id: widget.post.userId,
        firstName: widget.post.firstName,
        picturePath: widget.post.userPicturePath,
        location: widget.post.location,
        launchProfile: _goToProfile,
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
                  onPressed: widget.post.comments!.isEmpty ? null : _toggleComments,
                  icon: Icon(
                    Icons.comment,
                    color: Colors.white,
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
                onPressed: widget.post.comments!.isEmpty ? null : _toggleComments,
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          constraints: BoxConstraints(minHeight: _isComments == false ? 0 : 90),
          height: _isComments == false ? 0 : 90,
          child: ListView.builder(
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.post.comments![index]),
                Divider(),
              ],
            ),
            itemCount: widget.post.comments!.length,
          ),
        ),
      ),
      Divider(
        thickness: 2,
      ),
    ]);
  }
}
