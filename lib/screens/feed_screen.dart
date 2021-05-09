import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_coding/repository/user_network_repository.dart';
import 'package:insta_clone_coding/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Material.St AppBar
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Instagram',
      //     style: TextStyle(fontFamily: 'VeganStyle'),
      //   ),
      // ),
      /// Cupertino.St AppBar
      appBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.photo_camera_solid,
            color: Colors.black87,
          ),
        ),
        middle: Text(
          'instagram',
          style: TextStyle(fontFamily: 'VeganStyle'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: ImageIcon(
                  AssetImage('assets/images/actionbar_camera.png'),
                  color: Colors.black87,
                ),
                onPressed: () {}),
            IconButton(
                icon: ImageIcon(
                  AssetImage('assets/images/direct_message.png'),
                  color: Colors.black87,
                ),
                onPressed: () {})
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Post(index);
        },
      ),
    );
  }
}
