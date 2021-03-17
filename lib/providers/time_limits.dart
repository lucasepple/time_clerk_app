import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/activity.dart';

class TimeLimits with ChangeNotifier {
  Map<String, Map<Activity, int>> _limits = {
    'Monday': {},
    'Tuesday': {},
    'Wednesday': {},
    'Thursday': {},
    'Friday': {},
    'Saturday': {},
    'Sunday': {},
  };

  Map<String, Map<Activity, int>> get limits {
    return {..._limits};
  }

  void initTimeLimits() {
    for (Activity activity in Activity.values) {
      setTimeLimit('Monday', activity, 0);
      setTimeLimit('Tuesday', activity, 0);
      setTimeLimit('Wednesday', activity, 0);
      setTimeLimit('Thursday', activity, 0);
      setTimeLimit('Friday', activity, 0);
      setTimeLimit('Saturday', activity, 0);
      setTimeLimit('Sunday', activity, 0);
    }
  }

  void setTimeLimit(String day, Activity activity, int minutes) {
    _limits[day]!.update(
      activity,
      (int _) => minutes,
      ifAbsent: () => minutes,
    );
    notifyListeners();
  }
}
