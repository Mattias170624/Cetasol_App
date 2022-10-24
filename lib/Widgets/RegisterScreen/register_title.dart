// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'A 5 digit code has been\nsent to your device',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 75,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
              ),
              Icon(
                Icons.textsms_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 65,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
