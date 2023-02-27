import 'package:flutter/material.dart';

import '../providers/user.dart';

class DisplayFriends extends StatelessWidget {
  final List<Friend> friends;
  const DisplayFriends({required this.friends, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: 105,
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            scrollDirection: Axis.horizontal,
            children: friends.map((friend) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          'http://localhost:8080/assets/${friend.picturePath}',
                        ),
                      ),
                      FittedBox(
                        child: Text(friend.firstName),
                        fit: BoxFit.fitWidth,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
