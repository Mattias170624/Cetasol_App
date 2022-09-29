// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterCodeInput extends StatefulWidget {
  late final String email;
  final String password;
  late final int phone;

  RegisterCodeInput(this.email, this.password, this.phone);

  @override
  State<RegisterCodeInput> createState() => _RegisterCodeInputState();
}

class _RegisterCodeInputState extends State<RegisterCodeInput> {
  final _box1 = TextEditingController();
  final _box2 = TextEditingController();
  final _box3 = TextEditingController();
  final _box4 = TextEditingController();
  final _box5 = TextEditingController();
  final _box6 = TextEditingController();

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
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: _box1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: _box2,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box2,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: _box3,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box3,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: _box4,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box4,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: _box5,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box5,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (_) =>
                                    FocusScope.of(context).unfocus(),
                                controller: _box6,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: _box6,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (_) =>
                                    FocusScope.of(context).unfocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                    ],
                  ),
                )
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
                  onTap: _tempbutton,
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
            child: Platform.isAndroid
                ? ElevatedButton(
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
                  )
                : CupertinoButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: _handleContinueButton,
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

  void _tempbutton() {
    AuthService().sendSmsCode('+${widget.phone.toString()}');
  }

  void _handleContinueButton() async {
    var box1Num = _box1.value.text;
    var box2Num = _box2.value.text;
    var box3Num = _box3.value.text;
    var box4Num = _box4.value.text;
    var box5Num = _box5.value.text;
    var box6Num = _box6.value.text;

    var smsCode = box1Num + box2Num + box3Num + box4Num + box5Num + box6Num;

    final allAuthResults = await AuthService().createUserAuthProviders(
        smsCode, widget.phone.toString(), widget.email, widget.password);

    if (allAuthResults) {
      // User passed all auth tests, transfer to homescreen
      _showHomeScreen();
    }
  }

  void _showHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route route) => false);
  }
}
