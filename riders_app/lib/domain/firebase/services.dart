import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riders_app/core/global/app_var.dart';

class FirebaseServices {
  static Future<bool> updateDoc(
      String id, String collectionName, Map<String, dynamic> info) async {
    bool success = false;

    await fireStore
        .collection(collectionName)
        .doc(id)
        .set(info, SetOptions(merge: true))
        .then((value) => success = true);

    return success;
  }
}
