// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class QuestionsAndAnswers extends StatelessWidget {
  final _questionList = [
    {'Q: question 1 bla bla': 'A: Answer 1 bla bla..'},
    {'Q: question 2 bla bla': 'A: Answer 2 bla bla..'},
    {'Q: question 3 bla bla': 'A: Answer 3 bla bla..'},
    {'Q: question 4 bla bla': 'A: Answer 4 bla bla..'},
    {'Q: question 5 bla bla': 'A: Answer 5 bla bla..'},
    {'Q: question 6 bla bla': 'A: Answer 6 bla bla..'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Q&A',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 5, top: 5),
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _questionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text(
                    _questionList[index].keys.toString().substring(
                        1, _questionList[index].keys.toString().length - 1),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      _questionList[index].values.toString().substring(
                          1, _questionList[index].values.toString().length - 1),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Theme.of(context).colorScheme.primary,
                  height: 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
