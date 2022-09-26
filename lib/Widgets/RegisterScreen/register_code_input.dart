// ignore_for_file: prefer_const_constructors

import 'package:flutter/animation.dart';
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
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Verification',
              style: TextStyle(
                color: Colors.white,
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
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  'Enter your code',
                  style: TextStyle(
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
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => FocusScope.of(context).nextFocus(),
                          controller: box1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: '...',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => FocusScope.of(context).nextFocus(),
                          controller: box2,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: '...',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => FocusScope.of(context).nextFocus(),
                          controller: box3,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: '...',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => FocusScope.of(context).nextFocus(),
                          controller: box4,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: '...',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) => FocusScope.of(context).unfocus(),
                          controller: box5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Theme.of(context).colorScheme.onPrimary,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: '...',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1)
                          ],
                          style: TextStyle(color: Colors.white),
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
                    color: Colors.white,
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
            margin: EdgeInsets.only(bottom: 60),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
                fixedSize: Size(double.infinity, 40),
              ),
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
