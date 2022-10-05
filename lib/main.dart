// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/Screens/dynamic_home_screen.dart';
import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _SharedColorTheme().themedata,
      home: _decideStartScreen(),
    );
  }

  Widget _decideStartScreen() {
    if (AuthService().checkIfUserIsLoggedIn()) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}

class _SharedColorTheme {
  ThemeData themedata = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      error: Colors.red,
      onPrimary: Color(0xFFFF4d00),
      onError: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.black,
      primary: Color(0xFF143452),
      secondary: Color(0xFF8AC1EA),
      surface: Colors.black,
      onSecondary: Colors.black,
      background: Colors.black,
    ),
  );
}
