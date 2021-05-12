import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone_coding/repository/helper/image_helper.dart';

class ImageNetworkRepository {
  Future<StorageTaskSnapshot> uploadImageNCreateNewPost(File originImage,
      {@required String postKey}) async {
    try {
      final File resized = await compute(getResizedImage, originImage);
      // originImage
      //     .length()
      //     .then((value) => print('originalImage size : $value'));
      // resized.length().then((value) => print('resized Image size : $value'));
      // await Future.delayed(Duration(seconds: 3));
      final StorageReference storageReference =
          FirebaseStorage().ref().child(_getImagePathByPostKey(postKey));
      final StorageUploadTask uploadTask = storageReference.putFile(resized);
      return uploadTask.onComplete;
    } catch (e) {
      print(e);
    }
  }

  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';

  Future<dynamic> getPostImageUrl(String postKey) {
    return FirebaseStorage()
        .ref()
        .child(_getImagePathByPostKey(postKey))
        .getDownloadURL();
  }
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
