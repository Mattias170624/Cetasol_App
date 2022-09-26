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
    return Platform.isAndroid
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF143452),
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                error: Colors.black,
                onPrimary: Color(0xFFFF4d00),
                onError: Colors.black,
                onSurface: Colors.black,
                onBackground: Colors.black,
                primary: Color(0xFF143452),
                secondary: Color(0xFF8AC1EA),
                surface: Colors.black,
                onSecondary: Colors.black,
                background: Colors.black,
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                titleMedium: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                titleSmall: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            home: LoginScreen(),
          )
        : MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF143452),
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                error: Colors.black,
                onPrimary: Color(0xFFFF4d00),
                onError: Colors.black,
                onSurface: Colors.black,
                onBackground: Colors.black,
                primary: Color(0xFF143452),
                secondary: Color(0xFF8AC1EA),
                surface: Colors.black,
                onSecondary: Colors.black,
                background: Colors.black,
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                titleMedium: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                titleSmall: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            home: CupertinoApp(
              home: LoginScreen(),
            ),
          );
  }
}
