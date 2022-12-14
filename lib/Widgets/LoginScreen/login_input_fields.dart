// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/LoginScreen/reset_password_sheet.dart';
import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/dynamic_home_screen.dart';
import 'package:cetasol_app/Screens/signup_screen_1.dart';
import 'package:flutter/material.dart';

class LoginInputFields extends StatefulWidget {
  const LoginInputFields({super.key});

  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String passwordErrorText = '';

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
                            errorText:
                                'Password must be atleast 10 characters!')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: passwordErrorText.isNotEmpty,
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
              onTap: () => _handlePasswordResetButton(),
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
              onTap: _showRegisterPage,
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

  void _showRegisterPage() {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.reset();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpScreen1(),
      ),
    );
  }

  void _handleLoginButton() async {
    final emailText = _emailController.value.text;
    final passwordText = _passwordController.value.text;
    _setPasswordErrorText('');

    // If user input is invalid do not continue
    if (!_formKey.currentState!.validate()) return;

    final result = await AuthService().loginUser(emailText, passwordText);
    if (result == true) {
      _showHomeScreen();
    } else {
      _setPasswordErrorText(result);
    }
  }

  void _handlePasswordResetButton() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ResetPasswordSheet();
      },
    );
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
