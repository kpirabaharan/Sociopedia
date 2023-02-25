import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user-profile.dart';

// import '../providers/user_profile.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-page-screen';

  const ProfilePage({super.key});

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
      final userId = ModalRoute.of(context)!.settings.arguments as String;
      _userFuture = _obtainUserFuture(userId);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: const Text('Profile Page'),
        ),
      ),
    );
  }
}
