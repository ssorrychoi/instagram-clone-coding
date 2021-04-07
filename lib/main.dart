import 'package:flutter/material.dart';
import 'package:insta_clone_coding/home_page.dart';
import 'package:insta_clone_coding/screens/auth_screen.dart';

import 'constants/material_white.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: HomePage(),
      home: AuthScreen(),
    );
  }
}
