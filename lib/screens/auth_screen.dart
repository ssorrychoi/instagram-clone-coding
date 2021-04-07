import 'package:flutter/material.dart';
import 'package:insta_clone_coding/screens/profile_screen.dart';
import 'package:insta_clone_coding/widgets/fade_stack.dart';
import 'package:insta_clone_coding/widgets/sign_in_form.dart';
import 'package:insta_clone_coding/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> forms = [
    SignUpForm(),
    SignInForm(),
  ];
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FadeStack(
              selectedForm: selectedForm,
            ),
            Divider(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 40,
              child: Container(
                color: Colors.white,
                child: FlatButton(
                  shape: Border(top: BorderSide(color: Colors.grey)),
                  onPressed: () {
                    setState(() {
                      if (selectedForm == 0) {
                        selectedForm = 1;
                      } else {
                        selectedForm = 0;
                      }
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                        text: selectedForm == 0
                            ? "Dont't have an account? "
                            : 'Already have an account? ',
                        style: TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(
                              text: selectedForm == 0 ? 'Sign Up' : 'Sign In',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
