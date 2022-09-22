// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/RegisterScreen/register_header_icon.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceSafeHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Platform.isAndroid
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Sign up 1/2',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  height: deviceSafeHeight,
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
          )
        : CupertinoPageScaffold(
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
          );
  }
}
