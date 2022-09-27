// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.onSecondary,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Platform.isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _SharedColorTheme().themedata,
            home: LoginScreen(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _SharedColorTheme().themedata,
            home: CupertinoApp(
              home: LoginScreen(),
            ),
          );
  }
}

class _SharedColorTheme {
  ThemeData themedata = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      error: Colors.black,
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
