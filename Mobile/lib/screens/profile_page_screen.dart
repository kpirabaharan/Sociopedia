import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user-profile.dart';
import '../providers/user.dart';
import '../widgets/profile_overview.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-page-screen';
  final String userId;
  final bool isMainUser;

  const ProfilePage(this.userId, this.isMainUser, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _isInit = true;
  late Future _userFuture;

  Future _obtainUserFuture(String currentUserId) async {
    try {
      await Provider.of<UserProfile>(context, listen: false).fetchUser(currentUserId);
    } catch (err) {
      print(err);
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _userFuture = _obtainUserFuture(widget.userId);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text('An Error Occured!'));
            } else {
              return Consumer<UserProfile>(
                builder: (context, userData, child) => Scaffold(
                  body: Padding(
                    padding: EdgeInsets.only(top: mediaQuery.padding.top),
                    child: Stack(children: [
                      Padding(
                        padding: widget.isMainUser
                            ? const EdgeInsets.only(top: 12.0)
                            : EdgeInsets.all(0),
                        child: ProfileOverview(user: userData.user as User),
                      ),
                      if (!widget.isMainUser)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: IconButton(
                                icon: Platform.isIOS
                                    ? Icon(Icons.arrow_back_ios)
                                    : Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        )
                    ]),
                  ),
                ),
              );
            }
          }
        });
  }
}
