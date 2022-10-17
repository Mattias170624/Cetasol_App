// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class QuestionsAndAnswers extends StatefulWidget {
  @override
  State<QuestionsAndAnswers> createState() => _QuestionsAndAnswersState();
}

class _QuestionsAndAnswersState extends State<QuestionsAndAnswers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                  contentPadding: EdgeInsets.only(top: 15, bottom: 0),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text(
                    _questionList[index],
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: _returnAnswerText(index),
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

  // List of questions and their images
  Widget _returnAnswerText(int questionIndex) {
    switch (questionIndex + 1) {
      case 1:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'You might have already seen our software on our first case, Burö in Öckerö Kommun with successful registered saving of 17% (2020 and 2021) compared to the baseline year 2019.\n\nThe software for that vessel needs manual coding from our team for each case. Now we are designing a scalable software that reflects all the learning from that case and other cases\n\nThe old dashboard looked like this:'),
                _returnQuestionImage(questionIndex),
              ],
            ),
          ),
        );
      case 2:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Scalability does not mean only more customers, it means we can easily add more features and access your system remotely.'),
                _returnQuestionImage(questionIndex),
              ],
            ),
          ),
        );
      case 3:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'From September 2022 all pilot customers will have the new but basic software.'),
                _returnQuestionImage(questionIndex),
              ],
            ),
          ),
        );
      case 4:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'The software will only have very basic features and we will add features one by one to make sure all the aspects of the software is scalable. In the base\nsoftware you will get:\n'),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Adjustable brightness: Beside the display adjustment (0-100% with 20% interval).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Fuel Graph: Fuel graph will show fuel and distance.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Map: the map shows the position and tracking of the trip.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Gauges: we have two gauges that shows normalized fuel L/H and L/NM.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                  child: Text(
                    '- Fuel Budget: the bar on bottom right corner is showing total fuel consumption of the trip.',
                  ),
                ),
                _returnQuestionImage(questionIndex),
              ],
            ),
          ),
        );
      case 5:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The solution will have two interfaces: onboard vessel and cloud solution.\n\nThe onboard solution:',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Text(
                    '- Suggestion of optimal operation (speed-distance, engine speed-distance.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Re-calculation of the operation based on current status.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Actions to be taken (speed up or slow down to @rpm).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Estimated time of arrival (ETA).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Next Stops presentation.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Fuel consumption presentation in different categories (cruising, maneuvering, docking etc).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Normalized fuel consumption (L/H or L/NM).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Rest option, dark mode.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Login option for each crew.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Scoring (fuel and time schedule) the trip at the end.',
                  ),
                ),
                _returnQuestionImage(questionIndex),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'The cloud solution:',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Overview of the fleet.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Realtime status (location, fault codes etc.).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Insights (how to improve the operation? This changes based on system understanding main source of variability, main location of focus, % of following recommendations etc).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Energy Reporting page (full presentation and reporting).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Technical page (fault code history, potential maintenances).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Timetable and destinations (view and modify the destinations).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- The cloud will be available for all crew soon (only their own data).',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Text(
                    '- Admin.',
                  ),
                ),
                _returnQuestionImage(50),
              ],
            ),
          ),
        );
      case 6:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please create a ticket describing your wanted feature. When it has been requested by more customers then we add that to our development plan.',
                ),
                _returnQuestionImage(questionIndex),
              ],
            ),
          ),
        );
      case 7:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most features are going to be implemented in 2022Q4, there are some features that will be implement in 2023Q1.',
                ),
              ],
            ),
          ),
        );
      case 8:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The next release is W44-W45 and will include adding stops, speed guidance and directional guidance. We will send release note to you when it is ready.',
                ),
              ],
            ),
          ),
        );
      case 9:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'After 2023Q1, we have a good and scalable software and we will continue building on top on that. If you liked the process, you are welcome to be part of our second stage development.',
                ),
              ],
            ),
          ),
        );
      case 10:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'If you would like to report a bug or ask for a feature or give us feedback, please create a ticket describing your wishes.',
                ),
              ],
            ),
          ),
        );
      case 11:
        return DefaultTextStyle(
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please create a ticket above describing the problem to us.',
                ),
              ],
            ),
          ),
        );

      default:
        return Container();
    }
  }

  Widget _returnQuestionImage(int questionIndex) {
    switch (questionIndex + 1) {
      case 1:
        return Image.asset('assets/images/questionImage1.jpg');
      case 4:
        return Column(
          children: [
            Image.asset('assets/images/questionImage2.png'),
            SizedBox(
              height: 10,
            ),
            Image.asset('assets/images/questionImage2a.png'),
            SizedBox(
              height: 10,
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset('assets/images/questionImage2.png'),
            SizedBox(
              height: 10,
            ),
          ],
        );
      case 51:
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset('assets/images/questionImage4.png'),
            SizedBox(
              height: 10,
            ),
          ],
        );

      default:
        return SizedBox(
          height: 10,
        );
    }
  }

  final _questionList = [
    'Q: Why is Cetasol, designing a new software?',
    'Q: What is the benefit of the new software for me, besides being scalable?',
    'Q: From which date do we get the new software?',
    'Q: What features are included in the base software for September?',
    'Q: What will be the final software?',
    'Q: I liked the feature in the previous software, but it is missing in this design, what should I do?',
    'Q: When do I get the complete software?',
    'Q: What is in the next release and when?',
    'Q: What happens after 2023Q1?',
    'Q: How to can i contact you?',
    'Q: A feature is not working or displaying wrong information, what should I do?',
  ];
}
