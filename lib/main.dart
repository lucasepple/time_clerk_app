import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_clerk_app/providers/time_limits.dart';
import 'package:time_clerk_app/screens/bottom_tab_screen.dart';
import 'package:time_clerk_app/screens/month_stats_screen.dart';
import 'package:time_clerk_app/screens/overview_screen.dart';
import 'package:time_clerk_app/screens/profile_screen.dart';

void main() => runApp(TimeClerk());

class TimeClerk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TimeLimits(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Clerk',
        theme: ThemeData(
          primaryColor: Colors.white,
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
            bodyText1: TextStyle(
              // size Home Screen
              // fontSize: 17,
              fontSize: 18,
            ),
          ),
          buttonTheme: ButtonThemeData(
            height: 25,
            minWidth: 75,
          ),
        ),
        home: BottomTabScreen(),
      ),
    );
  }
}
