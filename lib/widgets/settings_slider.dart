import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:time_clerk_app/models/time_tracker.dart';
import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/providers/time_limits.dart';

class SettingsSlider extends StatefulWidget {
  final Activity activity;
  // get as argument
  final String selectedDay = 'Thursday';

  SettingsSlider(this.activity);

  @override
  _SettingsSliderState createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  double _currentSliderValue;
  bool isInit = false;
  var timeLimits;
  @override
  void didChangeDependencies() {
    if (!isInit) {
      timeLimits = Provider.of<TimeLimits>(context, listen: false);
      final currentLimit =
          timeLimits.limits[widget.selectedDay][widget.activity];
      if (currentLimit == null) {
        _currentSliderValue = 0;
      } else {
        _currentSliderValue = currentLimit.toDouble();
      }
      isInit = true;
    }
    super.didChangeDependencies();
  }

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
            timeLimits.setTimeLimit(
                widget.selectedDay, widget.activity, value.toInt());
          });
        },
        activeColor: ActivityProperties.colors[widget.activity],
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
