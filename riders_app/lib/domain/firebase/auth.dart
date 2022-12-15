import 'package:firebase_auth/firebase_auth.dart';

import '../../core/global/app_var.dart';
import '../../core/model/users.dart';

class AuthService {
  static Future<bool> createUser(
      User? firebaseUser, name, email, number, token, status) async {
    bool success = false;
    //  UsersModel user = UsersModel()

    // save user info to database
    Map<String, dynamic> userDataMap = {
      "id": firebaseUser!.uid,
      "name": name.trim(),
      "email": email.trim(),
      "phone": number.trim(),
      "token": token,
      "status": status
    };

    // await firebaseUser.updateDisplayName("user");

    await fireStore
        .collection("users_uber")
        .doc(firebaseUser.uid)
        .set(userDataMap)
        .then((value) async {
      await firebaseUser.updateDisplayName("user created");
    }).then((value) => success = true);

    return success;
  }

  static Future<UsersModel> getUser(String userid) async {
    UsersModel t = UsersModel();
    await fireStore.collection("users_uber").doc(userid).get().then((value) {
      t = UsersModel.fromMap(value.data());
    });

    print(t);
    return t;
  }
}
