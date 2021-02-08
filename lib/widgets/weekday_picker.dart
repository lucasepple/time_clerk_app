import 'package:flutter/material.dart';

class WeekdayPicker extends StatefulWidget {
  String dropdownValue;

  WeekdayPicker(this.dropdownValue);

  @override
  _WeekdayPickerState createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  final List<String> _items = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List<String> _dropdownList() {
    List<String> list = [];
    int j = _items.indexWhere((item) => item == widget.dropdownValue);
    for (int i = 0; i < 7; i++) {
      list.add(_items[j]);
      j++;
      if (j > 6) {
        j = 0;
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.dropdownValue,
        icon: Icon(
          Icons.arrow_drop_down,
          size: 0,
        ),
        items: _dropdownList().map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return _dropdownList().map<Widget>((String item) {
            return Row(
              children: [
                Text(
                  item,
                  style: Theme.of(context).textTheme.headline1.copyWith(
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
