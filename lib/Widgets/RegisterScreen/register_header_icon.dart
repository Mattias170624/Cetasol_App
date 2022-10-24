// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterHeaderIcon extends StatelessWidget {
  const RegisterHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Image.asset(
          'assets/images/cetasol_icon.png',
          height: 100,
          width: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
