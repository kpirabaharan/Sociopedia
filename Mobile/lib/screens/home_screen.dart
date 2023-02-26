import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post.dart';

import '../widgets/feed.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _refreshProducts() async {
    await Provider.of<Posts>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    print('Hi');
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Column(
          children: [
            Expanded(
                child: Feed(
              userId: '',
            )),
          ],
        ),
      ),
    );
  }
}
