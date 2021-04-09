import 'package:flutter/material.dart';
import 'package:insta_clone_coding/model/camera_state.dart';
import 'package:insta_clone_coding/model/gallery_state.dart';
import 'package:insta_clone_coding/widgets/my_gallery.dart';
import 'package:insta_clone_coding/widgets/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  CameraState _cameraState = CameraState();
  GalleryState _galleryState = GalleryState();

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    _galleryState.initProvider();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String title = "Photo";

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
        ChangeNotifierProvider<GalleryState>.value(value: widget._galleryState),
        // ChangeNotifierProvider(create: (context) => CameraState()),
      ],
      child: Scaffold(
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
            MyGallery(),
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
