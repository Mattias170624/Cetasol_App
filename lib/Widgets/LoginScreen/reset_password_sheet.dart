// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';

class ResetPasswordSheet extends StatefulWidget {
  @override
  State<ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends State<ResetPasswordSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        right: 20,
        left: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password reset',
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
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(),
                hintText: 'Email',
                errorStyle: TextStyle(height: 0.5),
                filled: true,
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              textInputAction: TextInputAction.done,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Required'),
                  EmailValidator(
                      errorText: "Please enter a valid email address"),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              'A verification process will be sent to this email',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 13,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 60),
            child: ElevatedButton(
              onPressed: _handleSendEmailButton,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
                fixedSize: Size(double.infinity, 40),
              ),
              child: Text(
                'Send',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendEmailButton() async {
    if (_formKey.currentState!.validate()) {
      print('Sending password reset to email...');
      print(_emailController.value.text);
      final result =
          await AuthService().sendPasswordReset(_emailController.value.text);
      if (result) Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
