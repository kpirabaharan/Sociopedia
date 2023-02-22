import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sociopedia'),
        actions: [
          IconButton(
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(child: Text('Home')),
    );
  }
}
