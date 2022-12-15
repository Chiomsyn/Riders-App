import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riders_app/core/model/users.dart';
import 'package:riders_app/domain/firebase/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/global/app_var.dart';
import '../../domain/notifications/push_notification.dart';

enum Status {
  uninitialized,
  userCreated,
  numberVerified,
  authenticating,
  authenticated,
  unauthenticated
}

class AuthHandler with ChangeNotifier {
  Status _status = Status.uninitialized;
  final FirebaseAuth _auth;
  UsersModel _user = UsersModel();
  String? verification;
  String otpCode = '';
  bool? isLoading = false;
  PhoneAuthCredential? _authCredential;

  int? resendToken = 0;

  Status get status => _status;
  UsersModel get user => _user;

  set status(Status val) {
    _status = val;
    notifyListeners();
  }

  set user(UsersModel val) {
    _user = val;
    notifyListeners();
  }

  AuthHandler.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  late List<String?> verificationCode;
  String? message = "";

  late List<TextEditingController?> textControllers;

  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> onOtpCodeSubmit() async {
    String code = '';
    isLoading = true;
    notifyListeners();
    bool yes = false;

    if (verificationCode.every((String? code) => code != null && code != '')) {
      code = verificationCode.join();
    }

    User? user = fAuth.currentUser;
    print(verification);

    if (verification != null) {
      print("hujkuh");
      try {
        print("herre");
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verification!, smsCode: code);
        print("ouhk");
        print(credential);
        // UserCredential credent = await user!.linkWithCredential(credential);
        // print(credent);
        print(user);
        await user!.updateDisplayName("user verified");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('userStatus', "user verified");
        signIn(credential);
        isLoading = false;
        yes = true;
        print("herre");
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          message = "User already exits";
          print(e.message);
        }
        isLoading = false;
        message = "OtpCode is not valid";
        notifyListeners();
        isLoading = false;
        notifyListeners();
        yes = false;
      }
    }
    return yes;
  }

  Future<bool> logUserIn() async {
    bool success = false;
    try {
      final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;

      if (firebaseUser != null) // user created
      {
        currentFirebaseUser = firebaseUser;
        print("Congratulations, Login Successfuly");
        success = true;
      } else {
        print("Error : Account was not created");
      }
    } catch (e) {
      print("${e}error");
    }

    return success;
  }

  Future<bool> _phoneSignIn() async {
    bool check = false;
    try {
      await fAuth
          .verifyPhoneNumber(
              phoneNumber: "+234${number.text}",
              verificationCompleted: _onVerificationCompleted,
              verificationFailed: _onVerificationFailed,
              codeSent: _onCodeSent,
              timeout: const Duration(seconds: 30),
              codeAutoRetrievalTimeout: _onCodeTimeout)
          .then((value) => check = true);
    } on Exception catch (e) {
      check = false;
    }
    return check;
  }

  Future<UsersModel> getUser(String uid) {
    return AuthService.getUser(uid);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    // print("verification completed ${authCredential.smsCode}");

    _authCredential = authCredential;

    otpCode = authCredential.smsCode ?? '';
    notifyListeners();
    print(otpCode);
    print("watsup");
  }

  signIn(PhoneAuthCredential authCredential) async {
    await fAuth.signInWithCredential(authCredential);
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      message = "Invalid Number submitted";
      // showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    resendToken = forceResendingToken;
    verification = verificationId;
    print("kiooio");
    print(verificationId);
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  saveUserToDb() {}

  resendCode() async {
    if (resendToken != null) {
      await fAuth.verifyPhoneNumber(
          phoneNumber: "+234${number.text}",
          verificationCompleted: _onVerificationCompleted,
          verificationFailed: _onVerificationFailed,
          codeSent: _onCodeSent,
          codeAutoRetrievalTimeout: _onCodeTimeout,
          forceResendingToken: resendToken);
    }
  }

  clearControllers() {
    email.clear();
    name.clear();
    number.clear();
    password.clear();
  }

  Future<bool> createUser() async {
    isLoading = true;
    notifyListeners();

    if (await createUserWithEmail()) {
      await _phoneSignIn();
      status = Status.userCreated;
      notifyListeners();
    }
    // } else {}

    message = "Congratulations, your account has been created.";
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> createUserWithEmail() async {
    try {
      final User? firebaseUser = (await fAuth.createUserWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;

      String token = await PushNotificationService().getToken();

      await AuthService.createUser(firebaseUser, name.text, email.text,
          "+234${number.text}", token, "created");

      currentFirebaseUser = firebaseUser;

      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future logOutUser() async {
    await fAuth.signOut();
  }

  Future<void> _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.uninitialized;
    } else {
      currentFirebaseUser = firebaseUser;
      _status = Status.authenticated;
      user = await AuthService.getUser(firebaseUser.uid);
    }
    notifyListeners();
  }
}
