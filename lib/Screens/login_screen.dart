// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/LoginScreen/login_header.dart';
import 'package:cetasol_app/Widgets/LoginScreen/login_input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    double deviceHeight = MediaQuery.of(context).size.height - padding;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 14, 38, 61),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  height: deviceHeight,
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
          )
        : CupertinoPageScaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  bottom: false,
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
