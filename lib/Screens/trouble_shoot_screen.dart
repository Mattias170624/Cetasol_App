// ignore_for_file: prefer_const_constructors

import 'package:cetasol_app/Widgets/NavScreenWidgets/TroublshootPage/questions_answers.dart';
import 'package:cetasol_app/Widgets/NavScreenWidgets/TroublshootPage/top_container.dart';
import 'package:flutter/material.dart';

class TroubleshootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondary,
                child: QuestionsAndAnswers(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
