// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginInputFields extends StatefulWidget {
  @override
  State<LoginInputFields> createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
                      : CupertinoTextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              CupertinoIcons.mail,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          placeholder: 'Email',
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
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
                      : CupertinoTextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              CupertinoIcons.mail,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          placeholder: 'Email',
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: addUser,
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
                    onPressed: () {},
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

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': 'name', // John Doe
          'company': 'test', // Stokes and Sons
          'age': '10' // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
