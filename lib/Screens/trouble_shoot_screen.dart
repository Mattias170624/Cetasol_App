// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/TroublshootPage/top_container.dart';
import 'package:flutter/material.dart';

class TroubleshootScreen extends StatelessWidget {
  const TroubleshootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double paddingBottom = MediaQuery.of(context).padding.bottom;
    double safeDeviceHeigt =
        MediaQuery.of(context).size.height - paddingTop - paddingBottom;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondary,
                child: TopContainer(),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
