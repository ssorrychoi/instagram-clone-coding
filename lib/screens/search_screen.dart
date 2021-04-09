import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            if (followings[index]) {
              setState(() {
                followings[index] = !followings[index];
              });
            }
          },
          leading: RoundedAvatar(),
          title: Text('user $index'),
          subtitle: Text('user bio Numver $index'),
          trailing: Container(
            height: 30,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: followings[index] ? Colors.blue[50] : Colors.red[50],
              border: Border.all(
                  color: followings[index] ? Colors.blue[50] : Colors.red,
                  width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Following',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
      itemCount: followings.length,
    ));
  }
}
