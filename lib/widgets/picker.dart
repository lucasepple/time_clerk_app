import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/screens/stats_screen.dart';

class Picker extends StatefulWidget {
  // improve receiving and hanling of current value
  String? currentValue;

  Function(String?)? updatePickedDay;
  StatsType? statsType;
  final String currentMonth = 'February';
  final int currentYear = 2021;

  Picker({
    this.statsType,
    this.currentValue,
    this.updatePickedDay,
  });

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  List<String> _dropdownList() {
    List<String> itemList = [];
    if (widget.statsType == StatsType.month) {
      // Better way instead of using Activity.sleep?
      if (TimeTracker().storedData[Activity.sleep]![widget.currentYear] !=
          null) {
        TimeTracker().storedData[Activity.sleep]!.forEach((year, map) {
          map.forEach((month, map) {
            itemList.add('$month $year');
          });
        });
      } else {
        itemList = ['${widget.currentMonth} ${widget.currentYear}'];
      }
    } else if (widget.statsType == StatsType.year) {
      // Better way instead of using Activity.sleep?
      if (TimeTracker().storedData[Activity.sleep] != null) {
        TimeTracker().storedData[Activity.sleep]!.forEach((year, map) {
          itemList.add('$year');
        });
      } else {
        itemList = [widget.currentYear.toString()];
      }
    } else {
      const List<String> weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];
      int j = weekdays.indexWhere((item) => item == widget.currentValue);
      for (int i = 0; i < 7; i++) {
        itemList.add(weekdays[j]);
        j++;
        if (j > 6) {
          j = 0;
        }
      }
    }
    widget.currentValue = itemList[0];
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownList = _dropdownList();
    String? selectedValue = dropdownList[0];
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedValue,
        icon: Icon(
          Icons.arrow_drop_down,
          size: 0,
        ),
        items: dropdownList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return dropdownList.map<Widget>((String item) {
            return Row(
              children: [
                Text(
                  item,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 20,
                      ),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            );
          }).toList();
        },
        underline: null,
        onChanged: (String? newValue) {
          setState(
            () {
              selectedValue = newValue;
              if (widget.statsType == null) widget.updatePickedDay!(newValue);
            },
          );
        },
      ),
    );
  }
}
