// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/images/cetasol_icon.png',
            height: 100,
            width: 100,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Troubleshooting',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('& Installation',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Container(
              height: 60,
              width: 3,
              margin: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            Text('Guide', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        Spacer(),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(MediaQuery.of(context).size.width, 100),
            ),
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
