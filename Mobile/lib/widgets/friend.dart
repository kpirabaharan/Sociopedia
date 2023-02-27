import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../providers/auth.dart';

class FriendListTile extends StatefulWidget {
  final String id;
  final String firstName;
  final String picturePath;
  final String location;
  final void Function()? launchProfile;

  const FriendListTile({
    required this.id,
    required this.firstName,
    required this.picturePath,
    required this.location,
    this.launchProfile,
    super.key,
  });

  @override
  State<FriendListTile> createState() => _FriendListTileState();
}

class _FriendListTileState extends State<FriendListTile> {
  late Future _getFriendsFuture;

  bool isUser = false;

  Future _obtainFriendsFuture() async {
    try {
      final userId = Provider.of<Auth>(context, listen: false).userId as String;
      await Provider.of<Auth>(context, listen: false).getFriends(userId);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    final userId = Provider.of<Auth>(context, listen: false).userId as String;
    isUser = userId == widget.id;
    _getFriendsFuture = _obtainFriendsFuture();
    super.initState();
  }

  void _toggleFriend() async {
    final userId = Provider.of<Auth>(context, listen: false).userId as String;
    await Provider.of<Auth>(context, listen: false).patchFriend(userId, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isFriend = false;
    List<String> friendIds = Provider.of<Auth>(context).friends;
    isFriend = friendIds.contains(widget.id);

    return FutureBuilder(
      future: _getFriendsFuture,
      builder: ((ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.error != null) {
            // Do Error Handling Here
            return Center(child: Text('An Error Occured!'));
          } else {
            return ListTile(
                leading: GestureDetector(
                  onTap: widget.launchProfile,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://localhost:8080/assets/${widget.picturePath}',
                    ),
                  ),
                ),
                title: GestureDetector(
                  onTap: widget.launchProfile,
                  child: Text(
                    widget.firstName,
                    // style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                subtitle: Text(widget.location),
                trailing: (!isUser)
                    ? (isFriend)
                        ? IconButton(onPressed: _toggleFriend, icon: Icon(Icons.person_remove))
                        : IconButton(onPressed: _toggleFriend, icon: Icon(Icons.person_add))
                    : SizedBox.shrink());
          }
        }
      }),
    );
  }
}
