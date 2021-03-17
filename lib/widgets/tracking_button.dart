import 'package:flutter/material.dart';

// import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/models/activity.dart';

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
    return Container(
      height: 25,
      width: 73,
      child: OutlinedButton(
        child: _start ? const Text('Start') : const Text('Stop'),
        style: OutlinedButton.styleFrom(
          backgroundColor: _start
              ? Colors.white
              : ActivityProperties.colors[widget.activity],
          primary: _start
              ? ActivityProperties.colors[widget.activity]
              : Colors.white,
          shape: StadiumBorder(),
          side: BorderSide(
            color: ActivityProperties.colors[widget.activity]!,
            width: 0.5,
          ),
          elevation: 0,
        ),
        onPressed: () {
          setState(() {
            _start = !_start;
          });
        },
      ),
    );
  }
}
