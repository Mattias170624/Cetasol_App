// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/Screens/signup_screen_2.dart';
import 'package:cetasol_app/Widgets/RegisterScreen/register_inputs.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterInputs extends StatefulWidget {
  @override
  State<RegisterInputs> createState() => _RegisterInputsState();
}

class _RegisterInputsState extends State<RegisterInputs> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 40,
          child: Platform.isAndroid
              ? TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _nameController,
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
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(
                          errorText: "Please enter a valid email address"),
                    ],
                  ),
                )
              : CupertinoTextField(
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
      ],
    );
  }
}


/*
Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 40,
            child: Platform.isAndroid
                ? TextFormField(
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
*/