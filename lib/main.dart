import 'package:flutter/material.dart';
import 'package:insta_clone_coding/home_page.dart';
import 'package:insta_clone_coding/model/fiirebase_auth_state.dart';
import 'package:insta_clone_coding/screens/auth_screen.dart';
import 'package:provider/provider.dart';

import 'constants/material_white.dart';
import 'widgets/my_progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return ChangeNotifierProvider<FirebaseAuthState>.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context, FirebaseAuthState firebaseAuthState,Widget child){
          switch(firebaseAuthState.firebaseAuthStatus){
            case FirebaseAuthStatus.signout:
              _currentWidget =  AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _currentWidget =  HomePage();
              break;
            default:
              _currentWidget =  MyProgressIndicator();
          }
         return AnimatedSwitcher(
           duration: Duration(milliseconds: 300),
             child: _currentWidget);
        },child: HomePage()),
        // home: AuthScreen(),
      ),
    );
  }
}
