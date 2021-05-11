import 'package:insta_clone_coding/model/firestore/user_model.dart';

String getNewPostKey(UserModel userModel) =>
    "${DateTime.now().millisecondsSinceEpoch}_${userModel.userKey}";
