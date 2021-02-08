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
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
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
              ),
              Stack(children: <Widget>[
                Positioned(
                  // make variable
                  top: 22 - 3.0,
                  left: 20,
                  child: Container(
                    height: 6,
                    width: 20,
                    decoration: BoxDecoration(
                      color: TimeTracker.activityColors[activity],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                  ),
                ),
                Positioned(
                  // make variable
                  top: 22 - 3.0,
                  right: 20,
                  child: Container(
                    height: 6,
                    width: 20,
                    decoration: BoxDecoration(
                      // make variable?
                      color: Color(0xffdddddd),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
                SettingsSlider(activity),
              ]),
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
          // padding: const EdgeInsets.all(20),
          // can maybe be removed
          padding: const EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
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
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: WeekdayPicker(currentWeekday),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 500,
                // color: Colors.grey,
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
