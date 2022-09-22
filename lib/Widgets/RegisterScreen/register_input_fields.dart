// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterInputFields extends StatefulWidget {
  @override
  State<RegisterInputFields> createState() => _RegisterInputFieldsState();
}

class _RegisterInputFieldsState extends State<RegisterInputFields> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 40,
            child: Platform.isAndroid
                ? TextField(
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                      labelText: 'Email',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                  )
                : CupertinoTextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.mail,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    placeholder: 'Email',
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 40,
            child: Platform.isAndroid
                ? TextField(
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                      labelText: 'Password',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  )
                : CupertinoTextField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.lock,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    obscureText: true,
                    placeholder: 'Password',
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 40,
            child: Platform.isAndroid
                ? TextField(
                    textInputAction: TextInputAction.done,
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      filled: true,
                      labelText: 'Phone Number',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.phone,
                    enableSuggestions: false,
                    autocorrect: false,
                  )
                : CupertinoTextField(
                    controller: _phoneNumberController,
                    textInputAction: TextInputAction.continueAction,
                    keyboardType: TextInputType.number,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.phone,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    placeholder: 'Phone Number',
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
          ),
          Text(
            'A verification code will be sent to this number on the next page',
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          Container(
            margin: Platform.isAndroid
                ? EdgeInsets.only(bottom: 60)
                : EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: Platform.isAndroid
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary,
                      fixedSize: Size(double.infinity, 40),
                    ),
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : CupertinoButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }
}
