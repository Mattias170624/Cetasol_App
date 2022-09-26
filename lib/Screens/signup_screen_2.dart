// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/RegisterScreen/register_code_input.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_header_icon.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_input_fields.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iOSNavbarHeight = MediaQuery.of(context).padding.top;
    double deviceSafeHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Platform.isAndroid
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Sign up 2/2',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                child: Container(
                  height: deviceSafeHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: RegisterTitle(),
                      ),
                      Expanded(
                        child: RegisterCodeInput(),
                      ),
                      // Expanded(
                      //   child: RegisterHeaderIcon(),
                      // ),
                      // Expanded(
                      //   flex: 2,
                      //   child: RegisterInputFields(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              middle: Text(
                'Sign up 2/2',
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                child: Container(
                  height: deviceSafeHeight - iOSNavbarHeight,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
          );
  }
}
