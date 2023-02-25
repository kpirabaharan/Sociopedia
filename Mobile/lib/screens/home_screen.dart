import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/post.dart';

import '../widgets/user_post.dart';
import '../widgets/feed.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _refreshProducts() {
    return Provider.of<Posts>(context, listen: false).fetchPosts();
  }

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
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Column(
          children: [
            Expanded(child: Feed()),
          ],
        ),
      ),
    );
  }
}
