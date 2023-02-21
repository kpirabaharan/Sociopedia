import 'package:flutter/material.dart';

import '../widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sociopedia'),
        // automaticallyImplyLeading: false,
      ),
      body: Feed(),
    );
  }
}
