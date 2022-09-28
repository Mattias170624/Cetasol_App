// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Widgets/RegisterScreen/register_code_input.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen2 extends StatelessWidget {
  final String email;
  final String password;
  final int phone;

  SignUpScreen2(this.email, this.password, this.phone);

  @override
  Widget build(BuildContext context) {
    double iOSNavbarHeight = MediaQuery.of(context).padding.top;
    double deviceSafeHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Platform.isAndroid
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'Sign up 2/2',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  height: deviceSafeHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: RegisterTitle(),
                      ),
                      Expanded(
                        flex: 2,
                        child: RegisterCodeInput(email, password, phone),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  height: deviceSafeHeight - iOSNavbarHeight,
                  child: Column(
                    children: [
                      Expanded(
                        child: RegisterTitle(),
                      ),
                      Expanded(
                        flex: 2,
                        child: RegisterCodeInput(email, password, phone),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
