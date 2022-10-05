// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/Screens/dynamic_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_1.dart';
import 'package:flutter/material.dart';

class LoginInputFields extends StatefulWidget {
  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPasswordError = false;
  String passwordErrorText = '';

  void _setPasswordVisibility(bool newValue) {
    setState(() {
      showPasswordError = newValue;
    });
  }

  void _setPasswordErrorText(String text) {
    setState(() {
      passwordErrorText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      errorStyle: TextStyle(height: 0.5),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: 'Required'),
                        EmailValidator(
                            errorText: "Please enter a valid email address"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      errorStyle: TextStyle(height: 0.5),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(10,
                            errorText: 'Password is too short')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: showPasswordError,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                passwordErrorText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 13,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () =>
                  FirestoreDatabase().checkDuplicatePhone('+46760578565'),
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleLoginButton,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
                fixedSize: Size(double.infinity, 40),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Padding(
            padding: Platform.isAndroid
                ? EdgeInsets.only(bottom: 20)
                : EdgeInsets.only(bottom: 0),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen1()),
                );
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLoginButton() async {
    final emailText = _emailController.value.text;
    final passwordText = _passwordController.value.text;
    _setPasswordVisibility(false);
    if (!_formKey.currentState!.validate()) return;

    final loginResult = await AuthService().loginUser(emailText, passwordText);
    if (loginResult.runtimeType == bool && loginResult == true) {
      if (loginResult) {
        _showHomeScreen();
      }
    } else {
      _setPasswordErrorText('Error logging in');
      _setPasswordVisibility(true);
    }
  }

  void _showHomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route route) => false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
