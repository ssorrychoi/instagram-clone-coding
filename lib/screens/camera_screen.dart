import 'package:flutter/material.dart';
import 'package:insta_clone_coding/widgets/take_photo.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String title = "Photo";

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                title = 'Gallery';
                break;
              case 1:
                title = 'Photo';
                break;
              case 2:
                title = 'Video';
                break;
            }
          });
        },
        controller: _pageController,
        children: [
          Container(
            color: Colors.red,
          ),
          TakePhoto(),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'GALLERY'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'PHOTO'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'VIDEO')
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}
