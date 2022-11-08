import '../core/global/app_var.dart';

class AuthService {
  static createUser(firebaseUser, name, email, number, token) async {
    // save user info to database
    Map<String, dynamic> userDataMap = {
      "id": firebaseUser.uid,
      "name": name.trim(),
      "email": email.trim(),
      "phone": number.trim(),
      "token": token
    };
    await fireStore
        .collection("users_uber")
        .doc(firebaseUser.uid)
        .set(userDataMap);
  }
}
