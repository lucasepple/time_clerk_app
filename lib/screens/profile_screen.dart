import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:time_clerk_app/helpers/string_converter.dart';
import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/providers/time_limits.dart';
import 'package:time_clerk_app/widgets/profile_list_tile.dart';
// import 'package:time_clerk_app/widgets/settings_slider.dart';
import 'package:time_clerk_app/widgets/weekday_picker.dart';

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

  void updatePickedDay(String newDay) {
    setState(() {
      widget.selectedWeekday = newDay;
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
                  child: WeekdayPicker(widget.selectedWeekday, updatePickedDay),
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
