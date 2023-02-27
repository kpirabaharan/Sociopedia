import 'package:flutter/material.dart';
import 'package:social_media_frontend/widgets/display_friends.dart';

import '../providers/user.dart';

class ProfileOverview extends StatefulWidget {
  final User user;
  const ProfileOverview({required this.user, super.key});

  @override
  State<ProfileOverview> createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview> {
  bool isShowFriends = false;

  Widget userStat(BuildContext ctx, String statTitle, int statNum) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            statNum.toString(),
            style: Theme.of(ctx).textTheme.headlineSmall,
          ),
        ),
        Text(
          statTitle,
          style: Theme.of(ctx).textTheme.titleSmall,
        ),
      ],
    );
  }

  void _toggleFriends() {
    setState(() {
      isShowFriends = !isShowFriends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(
              'http://localhost:8080/assets/${widget.user.picturePath}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '${widget.user.firstName} ${widget.user.lastName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.occupation,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 10,
                ),
                Text(
                  widget.user.location,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              color: Theme.of(context).cardColor,
              child: Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _toggleFriends,
                        child: userStat(context, 'Friends', widget.user.friends.length),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: userStat(context, 'Profile Views', widget.user.viewedProfile),
                    ),
                    Expanded(
                      flex: 1,
                      child: userStat(context, 'Impressions', widget.user.impressions),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isShowFriends ? DisplayFriends(friends: widget.user.friends) : SizedBox.shrink()
        ],
      ),
    );
  }
}
