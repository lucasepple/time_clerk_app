import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:time_clerk_app/helpers/string_converter.dart';
import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/models/activity.dart';
// import 'package:time_clerk_app/providers/time_limits.dart';
import 'package:time_clerk_app/widgets/profile_list_tile.dart';
// import 'package:time_clerk_app/widgets/settings_slider.dart';
import 'package:time_clerk_app/widgets/picker.dart';

class ProfileScreen extends StatefulWidget {
  String selectedWeekday;

  // needs to be current weekday!
  ProfileScreen({this.selectedWeekday = 'Thursday'});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<Activity, int> trackedTime = TimeTracker().trackedTime;

  final Map<String, Map<Activity, int>> timeLimits = TimeTracker().timeLimits;

  void updatePickedDay(String? newDay) {
    setState(() {
      widget.selectedWeekday = newDay!;
    });
  }

  List<Widget> listTileBuilder(BuildContext context) {
    List<Widget> list = [];
    // init for debugging
    // final timeLimits = Provider.of<TimeLimits>(context, listen: false);
    // timeLimits.initTimeLimits();
    for (Activity activity in Activity.values) {
      list.add(ProfileListTile(widget.selectedWeekday, activity));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Picker(
              currentValue: widget.selectedWeekday,
              updatePickedDay: updatePickedDay,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          // color: Colors.grey,
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              children: listTileBuilder(context),
              // Condition when device size is large enough
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        )
      ],
    );
  }
}
