import 'package:flutter/material.dart';

import 'package:time_clerk_app/screens/overview_screen.dart';

void main() => runApp(TimeClerk());

class TimeClerk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Clerk',
      theme: ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Muli',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      home: OverviewScreen(),
    );
  }
}
