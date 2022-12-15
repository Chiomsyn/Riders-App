import 'package:flutter/cupertino.dart';
import 'package:riders_app/domain/firebase/services.dart';

class UserServiceProvider with ChangeNotifier {
  bool _taskSucces = false;
  bool get taskSucces => _taskSucces;

  set taskSucces(bool val) {
    _taskSucces = taskSucces;
    notifyListeners();
  }

  Future<bool> updateUserStatus(id) async {
    try {
      await FirebaseServices.updateDoc(
          id, "user_uber", {"status": "profileUpdated"});
      _taskSucces = true;
    } catch (e) {
      _taskSucces = false;
    }

    return _taskSucces;
  }

  Future<bool> updateUserStatus1(id) async {
    try {
      await FirebaseServices.updateDoc(
          id, "users_uber", {"status": "profileFullyUpdated"});

      _taskSucces = true;
    } catch (e) {
      print(e.toString());
      _taskSucces = false;
    }

    return _taskSucces;
  }
}
