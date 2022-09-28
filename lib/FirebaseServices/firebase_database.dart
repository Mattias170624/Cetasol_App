import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/Models/user_model.dart';

import 'dart:io';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDatabase extends AuthService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addNewUser(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
