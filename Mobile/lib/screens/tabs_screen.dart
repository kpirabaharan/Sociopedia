import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_frontend/widgets/new_post.dart';

import '../providers/auth.dart';
import '../screens/home_screen.dart';
import '../screens/profile_page_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void didChangeDependencies() {
    final userId = Provider.of<Auth>(context, listen: false).userId as String;
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Sociopedia',
      },
      {
        'page': ProfilePage(userId, true),
        'title': 'Profile',
      }
    ];
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TabsScreen oldWidget) {
    final userId = Provider.of<Auth>(context, listen: false).userId as String;
    _pages = [
      {
        'page': HomeScreen(),
        'title': 'Sociopedia',
      },
      {
        'page': ProfilePage(userId, true),
        'title': 'Profile',
      }
    ];
    super.didUpdateWidget(oldWidget);
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    print(_selectedPageIndex);
  }

  void _createPost(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: NewPost(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (_selectedPageIndex == 0)
          ? FloatingActionButton(
              onPressed: () => _createPost(context),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
        title: Text('Sociopedia'),
        actions: [
          IconButton(
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }
}
