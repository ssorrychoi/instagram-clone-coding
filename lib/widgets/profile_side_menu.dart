import 'package:flutter/material.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  ProfileSideMenu(this.menuWidth, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              title: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
