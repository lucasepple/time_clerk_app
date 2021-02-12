import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_clerk_app/helpers/string_converter.dart';

import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/providers/time_limits.dart';
import 'package:time_clerk_app/widgets/settings_slider.dart';

class ProfileListTile extends StatelessWidget {
  final String selectedWeekday;
  final Activity activity;

  ProfileListTile(this.selectedWeekday, this.activity);

  @override
  Widget build(BuildContext context) {
    // use consumer instead?
    // final timeLimits = Provider.of<TimeLimits>(context, listen: false);
    // final limit = timeLimits.limits[currentWeekday][activity];
    // print(limit);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  ActivityProperties.strings[activity],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 19,
                      ),
                ),
                Consumer<TimeLimits>(
                  builder: (ctx, timeLimits, child) => Text(
                    StringConverter.timeString(
                        timeLimits.limits[selectedWeekday][activity]),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: ActivityProperties.colors[activity],
                          fontSize: 19,
                        ),
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
                  color: ActivityProperties.colors[activity],
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
            SettingsSlider(selectedWeekday, activity),
          ]),
        ],
      ),
    );
  }
}
