import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/constants/screen_size.dart';
import 'package:insta_clone_coding/repository/image_network_repository.dart';
import 'package:insta_clone_coding/widgets/my_progress_indicator.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  SharePostScreen(this.imageFile, {Key key, @required this.postKey})
      : super(key: key);

  List<String> _tagItems = ['apple', 'banana', 'kiwi', 'pear', 'tag', 'people'];
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          FlatButton(
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (_) => MyProgressIndicator(),
                isDismissible: false,
                enableDrag: false,
              );
              await imageNetworkRepository.uploadImageNCreateNewPost(imageFile,
                  postKey: postKey);
              Navigator.pop(context);
            },
            child: Text(
              'Share',
              textScaleFactor: 1.4,
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _captionWithImage(),
          _divider,
          _sectionButton('Tag People'),
          _divider,
          _sectionButton('Add Location'),
          _tags(),
          SizedBox(height: common_gap),
          _divider,
          SectionSwitch('Facebook'),
          SectionSwitch('Instagram'),
          SectionSwitch('Tumblr'),
          _divider,
        ],
      ),
    );
  }

  Tags _tags() {
    return Tags(
      horizontalScroll: true,
      itemCount: _tagItems.length,
      heightHorizontalScroll: 30,
      itemBuilder: (index) => ItemTags(
        title: _tagItems[index],
        index: index,
        activeColor: Colors.grey[200],
        textActiveColor: Colors.black,
        borderRadius: BorderRadius.circular(5),
        elevation: 2,
        splashColor: Colors.grey[800],
        color: Colors.red,
      ),
    );
  }

  Divider get _divider => Divider(
        color: Colors.grey[300],
        thickness: 1,
        height: 1,
      );

  ListTile _sectionButton(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.navigate_next),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
    );
  }

  ListTile _captionWithImage() {
    return ListTile(
      contentPadding:
          EdgeInsets.symmetric(vertical: common_gap, horizontal: common_gap),
      leading: Image.file(
        imageFile,
        width: size.width / 6,
        height: size.width / 6,
        fit: BoxFit.cover,
      ),
      title: TextField(
        decoration: InputDecoration(
            hintText: 'Write a caption...', border: InputBorder.none),
      ),
    );
  }
}

class SectionSwitch extends StatefulWidget {
  final String _title;

  const SectionSwitch(
    this._title, {
    Key key,
  }) : super(key: key);

  @override
  _SectionSwitchState createState() => _SectionSwitchState();
}

class _SectionSwitchState extends State<SectionSwitch> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget._title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: CupertinoSwitch(
          value: true,
          onChanged: (onValue) {
            setState(() {
              checked = onValue;
            });
          },
        ));
  }
}
