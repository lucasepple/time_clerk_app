import 'package:flutter/material.dart';

class WeekdayPicker extends StatefulWidget {
  String dropdownValue;

  WeekdayPicker(this.dropdownValue);

  @override
  _WeekdayPickerState createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.dropdownValue,
        icon: Icon(Icons.expand_more_rounded),
        items: <String>[
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        underline: null,
        onChanged: (String newValue) {
          setState(
            () {
              widget.dropdownValue = newValue;
            },
          );
        },
      ),
    );
  }
}
