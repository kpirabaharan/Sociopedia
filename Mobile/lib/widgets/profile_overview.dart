import 'package:flutter/material.dart';

import '../providers/user.dart';

class ProfileOverview extends StatelessWidget {
  final User user;
  const ProfileOverview({required this.user, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(
              'http://localhost:8080/assets/${user.picturePath}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '${user.firstName} ${user.lastName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.occupation,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 10,
                ),
                Text(
                  user.location,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    userStat(context, 'Friends', user.friends.length),
                    userStat(context, 'Profile Views', user.viewedProfile),
                    userStat(context, 'Impressions', user.impressions),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
