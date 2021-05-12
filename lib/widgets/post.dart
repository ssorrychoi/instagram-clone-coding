import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/constants/screen_size.dart';
import 'package:insta_clone_coding/repository/image_network_repository.dart';
import 'package:insta_clone_coding/widgets/comment.dart';
import 'package:insta_clone_coding/widgets/my_progress_indicator.dart';
import 'package:insta_clone_coding/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: false,
        userName: 'testingUser',
        text: 'I love MySelf!',
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: [
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
          color: Colors.black87,
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/comment.png')),
          color: Colors.black87,
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
          color: Colors.black87,
          onPressed: () {},
        ),
        Spacer(),
        IconButton(
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
          color: Colors.black87,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _postImage() {
    Widget progress = MyProgressIndicator(
      containerSize: size.width,
    );

    return FutureBuilder<dynamic>(
        future: imageNetworkRepository
            .getPostImageUrl('1620787690679_B1Hw8ypvdaNlcXsXTRTTpI6JzK22'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CachedNetworkImage(
              imageUrl: snapshot.data.toString(),
              placeholder: (context, url) {
                return progress;
              },
              imageBuilder: (context, imageProvider) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                );
              },
            );
          } else
            return progress;
        });
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('UserName')),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }
}
