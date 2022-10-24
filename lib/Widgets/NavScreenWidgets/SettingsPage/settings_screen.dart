// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cetasol_app/Widgets/NavScreenWidgets/SettingsPage/delete_sheet.dart';
import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Image.asset(
                    'assets/images/cetasol_icon.png',
                    height: 100,
                    width: 100,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.onSurface,
                width: double.infinity,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, top: 0, bottom: 5),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.mail,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        AuthService().auth.currentUser!.email!,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.phone,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        AuthService().auth.currentUser!.phoneNumber!,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    ListTile(
                      onTap: _handleDeleteButton,
                      visualDensity: VisualDensity(vertical: -4),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.person_remove,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      title: Text(
                        'Delete account',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Spacer(),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    ListTile(
                      onTap: _handleLogoutButton,
                      visualDensity: VisualDensity(vertical: -4),
                      horizontalTitleGap: 0,
                      leading: Icon(
                        Icons.exit_to_app_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      title: Text(
                        'Sign out',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Platform.isIOS ? 20 : 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogoutButton() async {
    await AuthService().signOutUser(context);
  }

  void _showDeleteUserSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DeleteSheet(),
        );
      },
    );
  }

  void _handleDeleteButton() async {
    if (AuthService().auth.currentUser == null) return;

    Navigator.pop(context);
    _showDeleteUserSheet();
  }
}
