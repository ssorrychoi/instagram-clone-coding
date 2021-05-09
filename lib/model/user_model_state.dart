import 'package:flutter/cupertino.dart';
import 'package:insta_clone_coding/model/firestore/user_model.dart';

class UserModelState extends ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel => _userModel;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
