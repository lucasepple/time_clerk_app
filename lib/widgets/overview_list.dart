import 'package:flutter/material.dart';
import 'package:time_clerk_app/helpers/string_converter.dart';

import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/widgets/tracking_button.dart';
import 'package:time_clerk_app/widgets/weekday_picker.dart';

class OverviewList extends StatelessWidget {
  final String currentWeekday;
  Map<Activity, int> trackedTime = TimeTracker().trackedTime;
  Map<String, Map<Activity, int>> timeLimits = TimeTracker().timeLimits;

  OverviewList(this.currentWeekday);

  List<Widget> listTileBuilder(BuildContext context) {
    List<Widget> list = [];
    for (Activity activity in Activity.values) {
      list.add(
        Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  TimeTracker.activityStrings[activity],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1,
                  children: <TextSpan>[
                    TextSpan(
                      text: StringConverter.timeString(trackedTime, activity),
                      style: TextStyle(
                        color: TimeTracker.activityColors[activity],
                        fontWeight: (trackedTime[activity] >
                                timeLimits[currentWeekday][activity])
                            ? FontWeight.w800
                            : FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: ' / ',
                    ),
                    TextSpan(
                      text: StringConverter.timeString(
                          timeLimits[currentWeekday], activity),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              TrackingButton(activity),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      // color: Colors.grey,
      child: ListView(
        children: listTileBuilder(context),
      ),
    );
  }
}
