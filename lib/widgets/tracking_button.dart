import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/providers/button_status.dart';

class TrackingButton extends StatelessWidget {
  final Activity activity;
  final bool active;

  TrackingButton(this.activity, this.active);

  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 73,
      child: OutlinedButton(
        child: active ? const Text('Stop') : const Text('Start'),
        style: OutlinedButton.styleFrom(
          backgroundColor:
              active ? ActivityProperties.colors[activity] : Colors.white,
          primary: active ? Colors.white : ActivityProperties.colors[activity],
          shape: StadiumBorder(),
          side: BorderSide(
            color: ActivityProperties.colors[activity]!,
            width: 0.5,
          ),
          elevation: 0,
        ),
        onPressed: () {
          if (activity == Activity.other && active == true) {
            return;
          } else {
            Provider.of<ButtonStatus>(context, listen: false)
                .changeButtonStatus(activity);
            print('Button pressed');
          }
        },
      ),
    );
  }
}
