// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 10),
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
                Text(
                  'Troubleshooting',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '& Installation',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
            Text(
              'Guide',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Spacer(),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.elliptical(MediaQuery.of(context).size.width, 100),
            ),
            child: Container(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
