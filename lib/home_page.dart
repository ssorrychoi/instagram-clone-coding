import 'package:flutter/material.dart';
import 'package:insta_clone_coding/feed_screen.dart';

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

  List<Widget> _screens = [
    FeedScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepOrangeAccent),
    Container(color: Colors.deepPurpleAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    setState(() {
      _selectedIndex = value;
    });
  }
}
