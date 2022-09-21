import 'dart:io';

import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  error: Colors.black,
                  onPrimary: Colors.black,
                  onError: Colors.black,
                  onSurface: Colors.black,
                  onBackground: Colors.black,
                  primary: Color(0xFF143452),
                  secondary: Color(0xFF8AC1EA),
                  surface: Colors.black,
                  onSecondary: Colors.black,
                  background: Colors.black),
            ),
            home: LoginScreen(),
          )
        : CupertinoApp(
            home: LoginScreen(),
          );
  }
}
