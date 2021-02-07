import 'dart:math';

import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/time_tracker.dart';

class OverviewChart extends StatelessWidget {
  Map<Activity, int> trackedTime = TimeTracker().trackedTime;
  Map<String, Map<Activity, int>> timeLimits = TimeTracker().timeLimits;
  String currentWeekday;
  static const double containerHeight = 170;

  OverviewChart(this.currentWeekday);

  double heightFactor() {
    List<int> times = [];
    for (Activity activity in Activity.values) {
      times.add(trackedTime[activity]);
      times.add(timeLimits[currentWeekday][activity]);
    }
    final int maxMinutes = times.reduce(max);
    final double factor = (containerHeight - 0.75) / maxMinutes;
    return factor;
  }

  List<Widget> chartBarBuilder() {
    List<Widget> bars = [];
    for (Activity activity in Activity.values) {
      bars.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.5),
          // color: Colors.amber,
          height: containerHeight,
          width: 45,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: heightFactor() * trackedTime[activity].toDouble(),
                width: 35,
                color: TimeTracker.activityColors[activity],
              ),
              Positioned(
                bottom: heightFactor() * timeLimits[currentWeekday][activity],
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 5,
                      height: 0.75,
                      color: TimeTracker.activityColors[activity],
                    ),
                    Container(
                      width: 35,
                      height: 0.75,
                      color: heightFactor() *
                                  timeLimits[currentWeekday][activity] >=
                              (heightFactor() *
                                      trackedTime[activity].toDouble() -
                                  0.75)
                          ? TimeTracker.activityColors[activity]
                          : Colors.white,
                    ),
                    Container(
                      width: 5,
                      height: 0.75,
                      color: TimeTracker.activityColors[activity],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return bars;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: 330,
            color: Color(0xff707070),
            height: 0.75,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: chartBarBuilder(),
            ),
          )
        ],
      ),
    );
  }
}
