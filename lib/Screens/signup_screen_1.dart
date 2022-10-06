// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/RegisterScreen/register_header_icon.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_input_fields.dart';
import 'package:flutter/material.dart';

class SignUpScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    double safeDeviceHeigt = MediaQuery.of(context).size.height -
        paddingTop -
        paddingBottom -
        kToolbarHeight;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Sign up 1/2',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: safeDeviceHeigt,
            child: Column(
              children: [
                Expanded(
                  child: RegisterHeaderIcon(),
                ),
                Expanded(
                  flex: 2,
                  child: RegisterInputFields(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
