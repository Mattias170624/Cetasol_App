// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/LoginScreen/login_header.dart';
import 'package:cetasol_app/Widgets/LoginScreen/login_input_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    double safeDeviceHeigt =
        MediaQuery.of(context).size.height - paddingTop - paddingBottom;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const ClampingScrollPhysics(),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            height: safeDeviceHeigt,
            child: Column(
              children: [
                Expanded(
                  child: LoginHeader(),
                ),
                Expanded(
                  child: LoginInputFields(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
