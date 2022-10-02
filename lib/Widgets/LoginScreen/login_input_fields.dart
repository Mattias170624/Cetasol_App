// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInputFields extends StatefulWidget {
  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  child: Platform.isAndroid
                      ? TextFormField(
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
                          validator: RequiredValidator(errorText: "Required"),
                        )
                      : CupertinoTextFormFieldRow(
                          prefix: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                CupertinoIcons.mail,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: EdgeInsets.zero,
                          placeholder: 'Email',
                          style: TextStyle(height: 1.5),
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: RequiredValidator(errorText: "Required"),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Platform.isAndroid
                      ? TextFormField(
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
                          validator: RequiredValidator(errorText: "Required"),
                        )
                      : CupertinoTextFormFieldRow(
                          prefix: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                CupertinoIcons.lock,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: EdgeInsets.zero,
                          placeholder: 'Password',
                          style: TextStyle(height: 1.5),
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          controller: _passwordController,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: RequiredValidator(errorText: "Required"),
                        ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => AuthService().auth.signOut(),
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
            child: Platform.isAndroid
                ? ElevatedButton(
                    onPressed: () {
                      if (_validateUserInputs()) {
                        // Login user to fire auth
                        // Transfer user to homescreen
                      }
                    },
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
                  )
                : CupertinoButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      if (_validateUserInputs()) {
                        // Login user to fire auth
                        // Transfer user to homescreen
                      }
                    },
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
                : EdgeInsets.only(bottom: 30),
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

  bool _validateUserInputs() {
    // Checks if user input is valid, then opens the next screen
    return (_formKey.currentState!.validate());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
