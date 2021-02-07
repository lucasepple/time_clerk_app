import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/time_tracker.dart';

class TrackingButton extends StatefulWidget {
  final Activity activity;

  TrackingButton(this.activity);

  @override
  _TrackingButtonState createState() => _TrackingButtonState();
}

class _TrackingButtonState extends State<TrackingButton> {
  bool _start = true;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: _start ? const Text('Start') : const Text('Stop'),
      disabledElevation: null,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      color:
          _start ? Colors.white : TimeTracker.activityColors[widget.activity],
      textColor:
          _start ? TimeTracker.activityColors[widget.activity] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: TimeTracker.activityColors[widget.activity],
          width: 0.5,
        ),
      ),
      onPressed: () {
        setState(() {
          _start = !_start;
        });
      },
    );
  }
}
