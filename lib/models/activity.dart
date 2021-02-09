import 'dart:ui';

enum Activity {
  sleep,
  work,
  leisure,
  sport,
  socialMedia,
  other,
}

class ActivityProperties {
  static const Map<Activity, Color> colors = {
    Activity.sleep: Color(0xff1f3b54),
    Activity.work: Color(0xff63baaa),
    Activity.leisure: Color(0xfff7ae25),
    Activity.sport: Color(0xffdb6012),
    Activity.socialMedia: Color(0xffa11006),
    Activity.other: Color(0xff9d9d9d),
  };

  static const Map<Activity, String> strings = {
    Activity.sleep: 'Sleep',
    Activity.work: 'Work',
    Activity.leisure: 'Leisure',
    Activity.sport: 'Sport',
    Activity.socialMedia: 'Social Media',
    Activity.other: 'Other',
  };
}
