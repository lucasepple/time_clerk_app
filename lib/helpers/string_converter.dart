// import 'package:time_clerk_app/models/activity.dart';

class StringConverter {
  static String timeString(int time) {
    String timeString;
    if (time != null && time != 0) {
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
    } else {
      timeString = '0h';
    }
    return timeString;
  }
}
