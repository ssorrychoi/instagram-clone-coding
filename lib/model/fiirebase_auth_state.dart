

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FirebaseAuthStatus{
  signout, progress,signin
}
class FirebaseAuthState extends ChangeNotifier{
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseUser _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void watchAuthChange(){
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser ==null){
        return ;
      }else if(firebaseUser != _firebaseUser){
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,{@required String email,@required String password}){
    _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).catchError((error){
      print(error);
      String _message = '';
      switch(error.code){
        case 'ERROR_WEAK_PASSWORD':
          _message = "비밀번호 잘 넣어줘~!";
          break;
        case'ERROR_INVALID_EMAIL':
          _message ='이메일 주소가 이상해!';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = '해당 이메일은 다른 사람이 쓰고있어!';
          break;
      }

      SnackBar snackBar = SnackBar(content: Text(_message));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void login(BuildContext context,{@required String email,@required String password}){
    _firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim()).catchError((error){
      print(error);
      String _message = '';
      switch(error.code){
        case 'ERROR_INVALID_EMAIL':
          _message = "메일 주소 고쳐!!";
          break;
        case'ERROR_WRONG_PASSWORD':
          _message ='비번 이상함.';
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

  void signOut(){
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if(_firebaseUser != null){
      _firebaseUser  = null;
      _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    }
    else{
      if(_firebaseUser != null){
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      }else{
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

}