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
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
        // make shapes varaible
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 22),
      ),
      child: Slider(
        divisions: 144,
        value: _currentSliderValue,
        min: 0,
        max: 720,
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

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = 6;
    // offset modified, replace through variable
    final double trackLeft = offset.dx + 30;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    // width modified, replace through variable
    final double trackWidth = parentBox.size.width - 60;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
