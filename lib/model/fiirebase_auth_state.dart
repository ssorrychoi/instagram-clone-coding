import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:insta_clone_coding/repository/user_network_repository.dart';
import 'package:insta_clone_coding/utils/simple_snackbar.dart';

enum FirebaseAuthStatus { signout, progress, signin }

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseUser _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin;
  bool initiated = false;

  void watchAuthChange() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        initiated ? changeFirebaseAuthStatus() : initiated = true;
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = '';
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "비밀번호 잘 넣어줘~!";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = '이메일 주소가 이상해!';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = '해당 이메일은 다른 사람이 쓰고있어!';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(content: Text("Please try again later!"));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email);
    }
  }

  void login(BuildContext context,
      {@required String email, @required String password}) {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = '';
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = "메일 주소 고쳐!!";
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = '비번 이상함.';
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = '유저 없는데?';
          break;
        case 'ERROR_USER_DISABLED':
          _message = '해당 유저 금지됨.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = '너무 많이 시도했음. ㅅㄱㄹ';
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = '해당 동작은 여기서는 금지임!';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      if (await _facebookLogin.isLoggedIn) {
        await _facebookLogin.logOut();
      }
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(context, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackBar(context, 'User cancel facebook Sign In');
        break;
      case FacebookLoginStatus.error:
        simpleSnackBar(context, 'Error while facebook Sign In');
        _facebookLogin.logOut();
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    //Todo: 토큰을 사용해서 파이어베이스로 로그인하기
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token);

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);

    final FirebaseUser user = authResult.user;

    if (user == null) {
      simpleSnackBar(context, '페북 로그인 잘 안됨. 다시하셈');
    } else {
      _firebaseUser = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  FirebaseUser get firebaseUser => _firebaseUser;
}
