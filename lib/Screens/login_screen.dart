// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/LoginScreen/login_header.dart';
import 'package:cetasol_app/Widgets/LoginScreen/login_input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    double deviceHeight = MediaQuery.of(context).size.height - padding;

    return Platform.isAndroid
        ? Scaffold(
            //backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
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
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: LoginHeader(),
                        ),
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
