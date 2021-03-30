import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appbar(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
          'ssorrychoi',
          textAlign: TextAlign.center,
        )),
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {},
        )
      ],
    );
  }
}
