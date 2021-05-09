import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone_coding/constants/firestore_keys.dart';
import 'package:insta_clone_coding/model/firestore/user_model.dart';
import 'package:insta_clone_coding/repository/helper/transforemers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef =
        Firestore.instance.collection(COLLECTION_USERS).document(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.setData(UserModel.getMapForCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return Firestore.instance
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots()
        .transform(toUser);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
