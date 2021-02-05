import 'package:intl/intl.dart';

class Date {
  String get currentDay {
    final day = DateFormat('EEEE').format(DateTime.now()).toString();
    print(day);
    return day;
  }

  String get currentDateString {
    final date = DateFormat('MMMM d, y').format(DateTime.now()).toString();
    return date;
  }
}
