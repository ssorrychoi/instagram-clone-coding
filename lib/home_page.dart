import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/screen_size.dart';
import 'package:insta_clone_coding/screens/camera_screen.dart';
import 'package:insta_clone_coding/screens/feed_screen.dart';
import 'package:insta_clone_coding/screens/profile_screen.dart';
import 'package:insta_clone_coding/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  int _selectedIndex = 0;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Widget> _screens = [
    FeedScreen(),
    SearchScreen(),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepOrangeAccent),
    // Container(color: Colors.deepPurpleAccent),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtnItemClick,
      ),
    );
  }

  void _onBtnItemClick(int value) {
    switch (value) {
      case 2:
        _openCamera();
        break;
      default:
        setState(() {
          _selectedIndex = value;
        });
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CameraScreen()));
    } else {
      SnackBar snackBar = SnackBar(
        content: Text('사진,파일,마이크 접근 허용 해주셔야 카메라 사용이 가능띠~'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
            // Scaffold.of(context).hideCurrentSnackBar();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
      // Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.microphone,
      Permission.mediaLibrary,
      Platform.isIOS ? Permission.photos : Permission.storage,
    ].request();
    bool permitted = true;
    status.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) {
        permitted = false;
      }
    });
    return permitted;
  }
}
