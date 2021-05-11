import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:insta_clone_coding/model/gallery_state.dart';
import 'package:insta_clone_coding/model/user_model_state.dart';
import 'package:insta_clone_coding/repository/helper/generate_post_key.dart';
import 'package:insta_clone_coding/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
          crossAxisCount: 3,
          children: getImages(context, galleryState),
        );
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    return galleryState.images
        .map(
          (localImage) => InkWell(
            onTap: () async {
              Uint8List bytes = await localImage.getScaledImageBytes(
                  galleryState.localImageProvider, 0.3);

              final String postKey =
                  getNewPostKey(Provider.of<UserModelState>(context).userModel);
              try {
                final path =
                    join((await getTemporaryDirectory()).path, '$postKey.png');

                File imageFile = File(path)..writeAsBytesSync(bytes);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SharePostScreen(
                              imageFile,
                              postKey: postKey,
                            )));
              } catch (e) {
                print(e);
              }
            },
            child: Image(
              image: DeviceImage(localImage, scale: 0.2),
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();
  }
}
