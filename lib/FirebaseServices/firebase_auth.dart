// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static String incomingVerificationId = '';
  static bool? smsHasSent;

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
    Timer(Duration(seconds: 2), () {
      auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {
          // Case when phone instantly completes the incoming auth sms without user inputs
        },
        verificationFailed: (error) {
          print(error);
        },
        codeSent: ((verificationId, forceResendingToken) {
          print('Sending sms..');

          incomingVerificationId = verificationId;
          smsHasSent = true;
        }),
        codeAutoRetrievalTimeout: (verificationId) {
          smsHasSent = false;
        },
      );
    });
  }

  Future<dynamic> addPhoneAuthProvider(String smsCode) async {
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
      verificationId: incomingVerificationId,
      smsCode: smsCode,
    );

    try {
      await auth.signInWithCredential(phoneCredential);
      return true;
    } catch (error) {
      print('Error: $error');

      // Case if the error depends on invalid code, or that code has expired
      if (smsHasSent == false) return null;
      return false;
    }
  }

  Future<bool> addEmailAuthProvider(
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

  Future<dynamic> loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      return error;
    }
  }
}
