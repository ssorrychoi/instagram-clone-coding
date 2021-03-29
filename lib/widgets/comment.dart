import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/widgets/rounded_avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String userName;
  final String text;
  final DateTime dateTime;

  const Comment({
    Key key,
    this.showImage = true,
    @required this.userName,
    @required this.text,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage) RoundedAvatar(size: 24),
        if (showImage) SizedBox(width: common_xxs_gap),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  TextSpan(text: '   '),
                  TextSpan(text: text, style: TextStyle(color: Colors.black87))
                ],
              ),
            ),
            if (dateTime != null)
              Text(
                dateTime.toIso8601String(),
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              )
          ],
        ),
      ],
    );
  }
}
