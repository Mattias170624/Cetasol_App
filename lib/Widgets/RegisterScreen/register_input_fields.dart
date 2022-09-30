// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterInputFields extends StatefulWidget {
  @override
  State<RegisterInputFields> createState() => _RegisterInputFieldsState();
}

class _RegisterInputFieldsState extends State<RegisterInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? emailErrorText;
  bool obscurePassword = true;
  bool isPhoneTextValid = false;
  bool showPhoneError = false;

  PhoneNumber number = PhoneNumber(isoCode: 'SE');
  late PhoneNumber _parsedNumber;
  String initialCountry = 'SE';

  void _changeEmailErrorText(String? text) {
    setState(() {
      emailErrorText = text;
    });
  }

  void _showObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _setPhoneTextValidity(bool newvalue) {
    setState(() {
      isPhoneTextValid = newvalue;
    });
  }

  void _hidePhoneError(bool newValue) {
    setState(() {
      showPhoneError = newValue;
    });
  }

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
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Platform.isAndroid
                      ? TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            fillColor: Theme.of(context).colorScheme.secondary,
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            errorText: emailErrorText,
                            errorStyle: TextStyle(height: 0.5),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
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
                                  errorText:
                                      "Please enter a valid email address"),
                            ],
                          ),
                        )
                      : CupertinoTextFormFieldRow(
                          prefix: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                CupertinoIcons.mail,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: EdgeInsets.zero,
                          placeholder: 'Email',
                          style: TextStyle(height: 1.5),
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "Required"),
                              EmailValidator(
                                  errorText:
                                      "Please enter a valid email address"),
                            ],
                          ),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Platform.isAndroid
                      ? TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: _showObscurePassword,
                              child: obscurePassword
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_outlined,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 20,
                                    ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            fillColor: Theme.of(context).colorScheme.secondary,
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            errorStyle: TextStyle(height: 0.5),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          controller: _passwordController,
                          enableSuggestions: false,
                          obscureText: obscurePassword,
                          autocorrect: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "Required"),
                              MinLengthValidator(10,
                                  errorText:
                                      'Must contain atleast 10 characters')
                            ],
                          ),
                        )
                      : CupertinoTextFormFieldRow(
                          prefix: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                CupertinoIcons.lock,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: EdgeInsets.zero,
                          placeholder: 'Password',
                          style: TextStyle(height: 1.5),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: _passwordController,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "Required"),
                              MinLengthValidator(10,
                                  errorText:
                                      'Must contain atleast 10 characters')
                            ],
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      color: showPhoneError
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: InternationalPhoneNumberInput(
                    autoValidateMode: AutovalidateMode.disabled,
                    validator: (_) => null,
                    textAlignVertical: TextAlignVertical.center,
                    spaceBetweenSelectorAndTextField: 0,
                    scrollPadding: EdgeInsets.all(0),
                    inputBorder: InputBorder.none,
                    selectorTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      leadingPadding: 15,
                      trailingSpace: false,
                      setSelectorButtonAsPrefixIcon: true,
                    ),
                    searchBoxDecoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      filled: true,
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      hintText: 'Search country',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1),
                      ),
                    ),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    initialValue: number,
                    onInputChanged: (newValue) => {_parsedNumber = newValue},
                    onInputValidated: (bool value) =>
                        _setPhoneTextValidity(value),
                  ),
                ),
                Visibility(
                  visible: showPhoneError,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Invalid phone number',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'A verification code will be sent to this number on the next page',
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 13,
            ),
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
                    onPressed: () async {
                      if (await _handleUserInputs()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen2(
                              _emailController.value.text,
                              _passwordController.value.text,
                              _parsedNumber.phoneNumber!,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.onPrimary,
                      fixedSize: Size(double.infinity, 40),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                  )
                : CupertinoButton(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      if (await _handleUserInputs()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen2(
                              _emailController.value.text,
                              _passwordController.value.text,
                              _parsedNumber.phoneNumber!,
                            ),
                          ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<bool> _handleUserInputs() async {
    var email = _emailController.value.text;
    _changeEmailErrorText(null);

    // Guard against invalid user inputs
    if (!_formKey.currentState!.validate()) return false;

    if (isPhoneTextValid) {
      _hidePhoneError(false);
    } else {
      _hidePhoneError(true);
      return false;
    }

    // Checks for duplicate emails, then proceeds to next page
    return await AuthService().checkIfEmailInUse(email).then(
      (value) {
        if (value) {
          _changeEmailErrorText(null);
          return true;
        } else {
          _changeEmailErrorText('Email is already in use');
          return false;
        }
      },
    );
  }
}
