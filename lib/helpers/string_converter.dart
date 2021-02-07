import 'package:time_clerk_app/models/time_tracker.dart';

class StringConverter {
  static String timeString(Map<Activity, int> map, Activity activity) {
    final int time = map[activity];
    String timeString;
    final int hours = time ~/ 60;
    final int minutes = time % 60;
    if (hours == 0) {
      timeString = '${minutes}min';
    } else {
      if (minutes == 0) {
        timeString = '${hours}h';
      } else {
        timeString = '${hours}h$minutes';
      }
    }
    return timeString;
  }
}
