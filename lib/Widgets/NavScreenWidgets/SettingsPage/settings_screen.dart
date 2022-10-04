import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Settings screen'),
          Text(
            'Logged in with\n${AuthService().auth.currentUser!.email}\n ${AuthService().auth.currentUser!.phoneNumber}',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              AuthService().signOutUser(context);
            },
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
