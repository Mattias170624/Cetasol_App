// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('User logged in!'),
          Text('Email: ${AuthService().auth.currentUser!.email}'),
          Text('Phone: ${AuthService().auth.currentUser!.phoneNumber}'),
          ElevatedButton(
            onPressed: () {
              AuthService().signOutUser(context);
            },
            child: Text('Sign out'),
          )
        ],
      )),
    );
  }
}
