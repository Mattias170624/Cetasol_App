// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cetasol_app/Widgets/RegisterScreen/register_code_input.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_title.dart';
import 'package:flutter/material.dart';

class SignUpScreen2 extends StatelessWidget {
  final String email;
  final String password;
  final String phone;

  SignUpScreen2(this.email, this.password, this.phone, {super.key});

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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            height: safeDeviceHeigt,
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
