import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riders_app/domain/auth.dart';

import '../core/global/app_var.dart';
import '../domain/notifications/push_notification.dart';

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
  String? verificationId;
  String otpCode = '123456';
  bool? isLoading = false;
  PhoneAuthCredential? _authCredential;

  int? resendToken = 0;

  Status get status => _status;

  set status(Status val) {
    _status = val;
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

    if (verificationCode.every((String? code) => code != null && code != '')) {
      code = verificationCode.join();
    }

    if (otpCode == code) {
      User? user = fAuth.currentUser;

      if (otpCode != null && _authCredential != null) {
        try {
          UserCredential credential =
              await user!.linkWithCredential(_authCredential!);
          signIn(_authCredential!);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'provider-already-linked') {
            message = "User already exits";
            print(message);
          }
        }
      }

      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      message = "OtpCode is not valid";
      notifyListeners();
      return false;
    }
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
              phoneNumber: number.text,
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

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    // print("verification completed ${authCredential.smsCode}");

    _authCredential = authCredential;

    // print(authCredential.smsCode);

    otpCode = authCredential.smsCode ?? '';
    notifyListeners();
    print(otpCode);
    print("watsup");

    // User? user = fAuth.currentUser;

    // if (otpCode != null && _authCredential != null) {
    //   try {
    //     UserCredential credential =
    //         await user!.linkWithCredential(_authCredential!);
    //     signIn(_authCredential!);
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'provider-already-linked') {
    //       message = "User already exits";
    //       print(message);
    //     }
    //   }
    // }
    // notifyListeners();
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
    verificationId = verificationId;
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  saveUserToDb() {}

  resendCode() async {
    if (resendToken != null) {
      await fAuth.verifyPhoneNumber(
          phoneNumber: number.text,
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
      final User? firebaseUser = (await fAuth
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text)
              .catchError((errmsg) {
        message = errmsg.toString();
      }))
          .user;

      String token = await PushNotificationService().getToken();

      await AuthService.createUser(
          firebaseUser, name.text, email.text, number.text, token);

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
    }
    notifyListeners();
  }
}
