// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/FirebaseServices/firebase_database.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:cetasol_app/FirebaseServices/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cetasol_app/Screens/signup_screen_2.dart';
import 'package:flutter/material.dart';

class RegisterInputFields extends StatefulWidget {
  const RegisterInputFields({super.key});

  @override
  State<RegisterInputFields> createState() => _RegisterInputFieldsState();
}

class _RegisterInputFieldsState extends State<RegisterInputFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String _usedDuplicatePhoneNumber = '';
  String _phoneErrorText = '';
  String? emailErrorText;
  bool isPhoneTextInvalid = false;
  bool obscurePassword = true;
  bool showPhoneError = false;

  PhoneNumber _parsedNumber = PhoneNumber(isoCode: '', phoneNumber: '');
  PhoneNumber number = PhoneNumber(isoCode: 'SE');
  String initialCountry = 'SE';

  void _setPreviousPhoneNumber(String text) {
    setState(() {
      _usedDuplicatePhoneNumber = text;
    });
  }

  void _setEmailErrorText(String? text) {
    setState(() {
      emailErrorText = text;
    });
  }

  void _setPhoneErrorText(String text) {
    setState(() {
      _phoneErrorText = text;
    });
  }

  void _setObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _setPhoneTextValidity(bool newvalue) {
    setState(() {
      isPhoneTextInvalid = newvalue;
    });
  }

  void _setPhoneError(bool newValue) {
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
                  child: TextFormField(
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
                    keyboardType: TextInputType.emailAddress,
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
                            errorText: "Please enter a valid email address"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _setObscurePassword,
                        child: obscurePassword
                            ? Icon(
                                Icons.remove_red_eye,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              )
                            : Icon(
                                Icons.remove_red_eye_outlined,
                                color: Theme.of(context).colorScheme.primary,
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
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: "Required"),
                        MinLengthValidator(10,
                            errorText: 'Must contain atleast 10 characters')
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
                      _phoneErrorText,
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleContinueButton,
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
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Text(
                  'By registering to this app you agree to our',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: _handleTOSbutton,
                  child: Text(
                    'Terms of Service and Privacy Policy',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void _handleTOSbutton() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Terms of Service',
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
              Text('Terms of Service text..'),
            ],
          ),
        );
      },
    );
  }

  void _handleContinueButton() async {
    if (await _validateUserInputs()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen2(
            _emailController.value.text,
            _passwordController.value.text,
            _parsedNumber.phoneNumber!,
          ),
        ),
      );
    } else {
      print('User input validation failed');
    }
  }

  Future<bool> _validateUserInputs() async {
    late bool validationResult1;
    late bool validationResult2;
    late bool validationResult3;
    late bool validationResult4;

    // 1: Case when email / password are invalid
    if (_formKey.currentState!.validate()) {
      validationResult1 = true;
    } else {
      validationResult1 = false;
    }

    // 2: Case when phone number is badly written
    if (isPhoneTextInvalid) {
      _setPhoneError(false);
      validationResult2 = true;
    } else {
      _setPhoneErrorText('Invalid phone number');
      _setPhoneError(true);
      validationResult2 = false;
    }

    // 3: Case when email is already in use
    if (validationResult1) {
      await AuthService()
          .checkDuplicateEmail(_emailController.value.text)
          .then((result) {
        if (result) {
          _setEmailErrorText(null);
          validationResult3 = true;
        } else {
          _setEmailErrorText('Email is already in use');
          validationResult3 = false;
        }
      });
    } else {
      validationResult3 = false;
    }

    // 4: Case if phone number is already in use
    if (validationResult2) {
      if (_parsedNumber.phoneNumber == _usedDuplicatePhoneNumber) {
        _setPhoneError(true);
        return false;
      }

      print('Reading database');
      await FirestoreDatabase()
          .checkDuplicatePhone(_parsedNumber.phoneNumber!)
          .then((result) {
        if (result == true) {
          _setPhoneError(false);
          validationResult4 = true;
        } else {
          _setPreviousPhoneNumber(_parsedNumber.phoneNumber!);
          validationResult4 = false;
          _setPhoneErrorText('Phone number already in use');
          _setPhoneError(true);
        }
      });
    } else {
      validationResult4 = false;
    }

    return (validationResult1 &&
        validationResult2 &&
        validationResult3 &&
        validationResult4);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
