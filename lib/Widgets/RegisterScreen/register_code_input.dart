// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/Screens/dynamic_home_screen.dart';
import 'package:cetasol_app/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class RegisterCodeInput extends StatefulWidget {
  late final String phoneNumber;
  late final String email;
  final String password;

  RegisterCodeInput(this.email, this.password, this.phoneNumber, {super.key});

  @override
  State<RegisterCodeInput> createState() => _RegisterCodeInputState();
}

class _RegisterCodeInputState extends State<RegisterCodeInput> {
  final _pinController = TextEditingController();
  bool showSmsError = false;
  String smsErrorText = '';

  void _showSmsError(bool value) {
    setState(() {
      showSmsError = value;
    });
  }

  void _changeSmsErrorText(String newErrorText) {
    setState(() {
      smsErrorText = newErrorText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Verification',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20, top: 5),
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  'Enter your code',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 6,
                        controller: _pinController,
                        errorText: smsErrorText,
                        forceErrorState: showSmsError,
                        errorTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        animationDuration: Duration(milliseconds: 100),
                        defaultPinTheme: PinTheme(
                          width: 45,
                          height: 45,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.all(0),
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Didn't recieve any text?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: _handleResendCodeButton,
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: Platform.isAndroid
                ? EdgeInsets.only(bottom: 60)
                : EdgeInsets.only(bottom: 0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleContinueButton,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
                fixedSize: Size(double.infinity, 40),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleResendCodeButton() {
    if (AuthService.smsHasSent == null) return;

    if (AuthService.smsHasSent!) {
      _changeSmsErrorText('Wait 1 minute before resending');
      _showSmsError(true);
    } else {
      print('Sending a new code now..');
      _showSmsError(false);
      AuthService().sendSmsCode(widget.phoneNumber);
    }
  }

  void _handleContinueButton() async {
    if (!_checkUserInput(_pinController.text)) return;

    // Check if user has a valid phone
    final phoneProviderResult =
        await AuthService().addPhoneAuthProvider(_pinController.text);
    if (phoneProviderResult.runtimeType == bool) {
      if (!phoneProviderResult) {
        _changeSmsErrorText('Entered code is wrong');
        _showSmsError(true);
        return;
      }
    } else if (phoneProviderResult == null) {
      _changeSmsErrorText('Current code has expired');
      return;
    }

    // Make user able to login with email and password
    final emailProviderResult =
        await AuthService().addEmailAuthProvider(widget.email, widget.password);
    if (emailProviderResult) {
    } else {
      return;
    }

    // Add user to cloud database
    final addUserToDbResult = await FirestoreDatabase().addNewUser(
      UserModel(widget.email, widget.phoneNumber),
    );
    if (addUserToDbResult) {
      _showHomeScreen();
    } else {
      print('User failed final test');
    }
  }

  bool _checkUserInput(String text) {
    final validCharacters = RegExp(r'^[0-9]+$');

    if (text.length < 6) {
      _showSmsError(true);
      _changeSmsErrorText('Please fill in all fields.');
      return false;
    }

    if (!text.contains(validCharacters)) {
      _showSmsError(true);
      _changeSmsErrorText('Please use only numbers.');
      return false;
    }

    _showSmsError(false);
    return true;
  }

  void _showHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route route) => false);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthService().sendSmsCode(widget.phoneNumber);
    });
  }
}
