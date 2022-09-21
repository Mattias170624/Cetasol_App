import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            body: Center(
              child: Text('test'),
            ),
          )
        : CupertinoPageScaffold(
            child: Text('test'),
          );
  }
}
