import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/post.dart';
import './providers/user-profile.dart';
import './screens/auth_prompt_screen.dart';
import './screens/auth_screen.dart';
import './screens/tab_screen.dart';
import './screens/home_screen.dart';
import './screens/profile_page_screen.dart';

//TODO: Add Connection State and Error Checks to FutureBuilders
//TODO: Proper Error Handling for Every Catch Statment and Fetch Requests
//! Make Page Scrollable

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor darkColor = MaterialColor(
      0xFF174378,
      const <int, Color>{
        50: Color(0xFF7F98B5),
        100: Color(0xFF748EAE),
        200: Color(0xFF5D7BA1),
        300: Color(0xFF456993),
        400: Color(0xFF2E5685),
        500: Color(0xFF174378),
        600: Color(0xFF153C6C),
        700: Color(0xFF123660),
        800: Color(0xFF102F54),
        900: Color(0xFF0E2848),
      },
    );
    final lightTheme = ThemeData(
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(secondary: Colors.orange),
      fontFamily: 'Rubik',
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
    final darkTheme = ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(headlineSmall: TextStyle(fontWeight: FontWeight.bold)));
    // ThemeData(
    //   colorScheme:
    //       ColorScheme.fromSwatch(primarySwatch: darkColor).copyWith(secondary: Colors.blue),
    //   fontFamily: 'Rubik',
    //   textTheme: TextTheme(
    //     bodyLarge: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Rubik'),
    //     titleLarge: TextStyle(
    //       color: Colors.white,
    //     ),
    //     titleMedium: TextStyle(color: Colors.white),
    //     labelMedium: TextStyle(
    //       color: Colors.black,
    //     ),
    //   ),
    //   iconTheme: IconThemeData(
    //     color: Color.fromARGB(183, 52, 94, 150),
    //   ),
    //   cardColor: Color.fromRGBO(208, 206, 206, 0.796),
    //   canvasColor: Color.fromARGB(255, 48, 48, 48),
    // );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, UserProfile>(
          create: (ctx) => UserProfile('', null),
          update: (ctx, auth, previousUser) => UserProfile(
            auth.token ?? '',
            previousUser!.user,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Posts>(
          create: (ctx) => Posts('', []),
          update: (ctx, auth, previousPosts) => Posts(
            auth.token ?? '',
            previousPosts == null ? [] : previousPosts.posts,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sociopedia',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            home: auth.isAuth
                ? TabScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, snapshot) => AuthPromptScreen()),
            routes: {
              // HomeScreen.routeName: (ctx) => HomeScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
              ProfilePage.routeName: (ctx) => ProfilePage(),
            }),
      ),
    );
  }
}
