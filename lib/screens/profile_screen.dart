import 'package:flutter/material.dart';

import 'package:time_clerk_app/helpers/string_converter.dart';
import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/widgets/settings_slider.dart';
import 'package:time_clerk_app/widgets/weekday_picker.dart';

class ProfileScreen extends StatelessWidget {
  final String currentWeekday = 'Thursday';
  final Map<Activity, int> trackedTime = TimeTracker().trackedTime;
  final Map<String, Map<Activity, int>> timeLimits = TimeTracker().timeLimits;

  List<Widget> listTileBuilder(BuildContext context) {
    List<Widget> list = [];
    for (Activity activity in Activity.values) {
      list.add(
        Container(
          height: 85,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    TimeTracker.activityStrings[activity],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    StringConverter.timeString(
                        timeLimits[currentWeekday], activity),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: TimeTracker.activityColors[activity],
                        ),
                  ),
                ],
              ),
              SettingsSlider(activity),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'john.doe@mail.com',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: WeekdayPicker(currentWeekday),
              ),
              Container(),
              Container(
                width: double.infinity,
                height: 500,
                //color: Colors.grey,
                child: ListView(
                  children: listTileBuilder(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
