import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/time_tracker.dart';

class SettingsSlider extends StatefulWidget {
  Activity activity;

  SettingsSlider(this.activity);

  @override
  _SettingsSliderState createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(trackShape: CustomTrackShape()),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
        activeColor: TimeTracker.activityColors[widget.activity],
        inactiveColor: Color(0xffdddddd),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
