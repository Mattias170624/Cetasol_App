// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterCodeInput extends StatefulWidget {
  @override
  State<RegisterCodeInput> createState() => _RegisterCodeInputState();
}

class _RegisterCodeInputState extends State<RegisterCodeInput> {
  final box1 = TextEditingController();
  final box2 = TextEditingController();
  final box3 = TextEditingController();
  final box4 = TextEditingController();
  final box5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Verification',
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  'Enter your code',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: box1,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: box1,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: box2,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: box2,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: box3,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: box3,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                controller: box4,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: box4,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).nextFocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Platform.isAndroid
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onChanged: (_) =>
                                    FocusScope.of(context).unfocus(),
                                controller: box5,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: '...',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              )
                            : CupertinoTextField(
                                placeholder: '...',
                                textAlign: TextAlign.center,
                                controller: box5,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (_) =>
                                    FocusScope.of(context).unfocus(),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1)
                                ],
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                placeholderStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Didn't recieve any text?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: Platform.isAndroid
                ? EdgeInsets.only(bottom: 60)
                : EdgeInsets.only(bottom: 0),
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
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    );
  }
}
