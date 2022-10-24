// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:cetasol_app/Screens/login_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteSheet extends StatefulWidget {
  @override
  State<DeleteSheet> createState() => _DeleteSheetState();
}

class _DeleteSheetState extends State<DeleteSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _emailErrorText = '';
  String _passwordErrorText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Account validation is required before terminating your account. Once deleted, all data associated with your account will be permanently deleted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verify account',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20, top: 5),
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    labelText: 'Email',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "Text can't be empty!"),
                      EmailValidator(errorText: 'Invalid email format'),
                    ],
                  ),
                ),
                Visibility(
                  visible: _emailErrorText.isNotEmpty,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, top: 3),
                    child: Text(
                      _emailErrorText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    labelText: 'Password',
                    errorStyle: TextStyle(height: 0.5),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  validator: MultiValidator(
                    [RequiredValidator(errorText: "Text can't be empty!")],
                  ),
                ),
                Visibility(
                  visible: _passwordErrorText.isNotEmpty,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 10, top: 3),
                    child: Text(
                      _passwordErrorText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleUserInputs,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary,
                      fixedSize: Size(double.infinity, 40),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setEmailErrorText(String newText) {
    setState(() {
      _emailErrorText = newText;
    });
  }

  void _setPasswordErrorText(String newText) {
    setState(() {
      _passwordErrorText = newText;
    });
  }

  void _handleUserInputs() async {
    _setPasswordErrorText('');
    _setEmailErrorText('');

    if (!_formKey.currentState!.validate()) return;

    try {
      await AuthService()
          .handleSignIn(_emailController.text, _passwordController.text);
      _handleDeleteUser();
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-not-found':
          _setEmailErrorText('Wrong email!');
          break;

        case 'wrong-password':
          _setPasswordErrorText('Wrong password!');
          break;

        default:
          _setPasswordErrorText('Too many requests!');
          break;
      }
    }
  }

  void _handleDeleteUser() async {
    Future.wait([
      FirestoreDatabase().deleteNumberFromList(),
      FirestoreDatabase().deleteUserTickets(),
      FirestoreDatabase().deleteUserDocument(),
      FirestoreDatabase().deleteAllUserImages(),
    ]).then((resultList) async {
      print('OOO $resultList');
      if (resultList.contains(false) || resultList.contains(true)) {
        print('No test had null or errors');
        await AuthService().removeUserAuth(context);
        _showLoginScreen();
      } else {
        print('Error in results!');
        print(resultList);
      }
    }).onError((error, stackTrace) {
      print('@@@@ $error');
    });
  }

  void _showLoginScreen() {
    print('4');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route route) => false);
  }
}
