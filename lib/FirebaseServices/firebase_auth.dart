// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/Models/user_model.dart';
import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static String incomingVerificationId = '';

  Future<User> handleSignIn(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  bool checkIfUserIsLoggedIn() {
    if (auth.currentUser != null) {
      print('Logged in with user ${auth.currentUser!.email}');
      return true;
    } else {
      print('No logged in user');
      return false;
    }
  }

  Future<bool> checkDuplicateEmail(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (list.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      print(error);
      return true;
    }
  }

  Future sendSmsCode(String number) async {
    auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 30),
      verificationCompleted: (phoneAuthCredential) {
        // Case when phone instantly completes the incoming auth sms without user inputs
        print('1');
      },
      verificationFailed: (error) {
        print('2 $error');
      },
      codeSent: ((verificationId, forceResendingToken) {
        incomingVerificationId = verificationId;
        print('3');
      }),
      codeAutoRetrievalTimeout: (verificationId) {
        // Case when sms code duration runs out
      },
    );
  }

  Future<bool> createUserAuthProviders(
      String smsCode, String phone, String email, String password) async {
    dynamic phoneAuthResult = await _addPhoneAuthProvider(smsCode);
    dynamic emailAuthResult = await _addEmailAuthProvider(email, password);

    // Checking result of both auths.
    // If both are type bool and also both true, then return true
    if (phoneAuthResult.runtimeType == bool &&
        emailAuthResult.runtimeType == bool) {
      if (phoneAuthResult && emailAuthResult) {
        await FirestoreDatabase().addNewUser(
          UserModel(email, phone),
        );
        return true;
      }
    }
    return false;
  }

  Future<dynamic> _addPhoneAuthProvider(String smsCode) async {
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
      verificationId: incomingVerificationId,
      smsCode: smsCode,
    );

    late bool isNewUser;
    await auth.signInWithCredential(phoneCredential).then((value) {
      return isNewUser = (value.additionalUserInfo!.isNewUser);
    }).onError((error, stackTrace) {
      return isNewUser = false;
    });
    return isNewUser;
  }

  Future<bool> _addEmailAuthProvider(
      String emailInput, String passwordInput) async {
    AuthCredential emailCredential = EmailAuthProvider.credential(
      email: emailInput,
      password: passwordInput,
    );

    try {
      await auth.currentUser!.linkWithCredential(emailCredential);
      return true;
    } catch (error) {
      print(error);

      return false;
    }
  }

  Future<void> signOutUser(BuildContext context) {
    return auth.signOut().whenComplete(() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route route) => false);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
