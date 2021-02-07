import 'dart:async';
import 'dart:ui';

import 'package:cron/cron.dart';
import 'package:intl/intl.dart';

enum Activity {
  sleep,
  work,
  leisure,
  sport,
  socialMedia,
  other,
}

class TimeTracker {
  int currentYear;
  String currentMonth;
  int currentDay;
  var currentActivity = Activity.other;

  // cutom values for testing
  Map<Activity, int> _trackedTime = {
    Activity.sleep: 455,
    Activity.work: 372,
    Activity.leisure: 137,
    Activity.sport: 10,
    Activity.socialMedia: 78,
    Activity.other: 144,
  };

  Map<String, Map<Activity, int>> _timeLimits = {
    'Monday': {},
    'Tuesday': {},
    'Wednesday': {},
    'Thursday': {},
    'Friday': {},
    'Saturday': {},
    'Sunday': {},
  };
  static const Map<Activity, Color> activityColors = {
    Activity.sleep: Color(0xff1f3b54),
    Activity.work: Color(0xff63baaa),
    Activity.leisure: Color(0xfff7ae25),
    Activity.sport: Color(0xffdb6012),
    Activity.socialMedia: Color(0xffa11006),
    Activity.other: Color(0xff9d9d9d),
  };
  static const Map<Activity, String> activityStrings = {
    Activity.sleep: 'Sleep',
    Activity.work: 'Work',
    Activity.leisure: 'Leisure',
    Activity.sport: 'Sport',
    Activity.socialMedia: 'Social Media',
    Activity.other: 'Other',
  };

  Map<Activity, Stopwatch> stopwatches = {
    Activity.sleep: Stopwatch(),
    Activity.work: Stopwatch(),
    Activity.leisure: Stopwatch(),
    Activity.sport: Stopwatch(),
    Activity.socialMedia: Stopwatch(),
    Activity.other: Stopwatch(),
  };
  Timer timer;
  Map<Activity, Map<int, Map<String, Map<int, int>>>> storedData = {
    Activity.sleep: {},
    Activity.work: {},
    Activity.leisure: {},
    Activity.sport: {},
    Activity.socialMedia: {},
    Activity.other: {},
  };

  Map<Activity, int> get trackedTime {
    return _trackedTime;
  }

  Map<String, Map<Activity, int>> get timeLimits {
    // init and random values for testing
    initTimeLimits();
    _timeLimits['Thursday'] = {
      Activity.sleep: 480,
      Activity.work: 480,
      Activity.leisure: 210,
      Activity.sport: 100,
      Activity.socialMedia: 60,
      Activity.other: 270,
    };

    return _timeLimits;
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
    _timeLimits[day].update(
      activity,
      (int _) => minutes,
      ifAbsent: () => minutes,
    );
  }

  void initTrackedTime() {
    _trackedTime = {
      Activity.sleep: 0,
      Activity.work: 0,
      Activity.leisure: 0,
      Activity.sport: 0,
      Activity.socialMedia: 0,
      Activity.other: 0,
    };
  }

  Future<void> saveCurrentData() async {
    for (Activity activity in Activity.values) {
      if (!storedData[activity].containsKey(currentYear)) {
        storedData[activity][currentYear] = {};
      }
      if (!storedData[activity][currentYear].containsKey(currentMonth)) {
        storedData[activity][currentYear][currentMonth] = {};
      }
      storedData[activity][currentYear][currentMonth][currentDay] =
          _trackedTime[activity];
    }
  }

  void startStopwatch(Stopwatch stopwatch) {
    if (stopwatch.elapsedTicks != 0) {
      final duration = Duration(seconds: (60 - stopwatch.elapsedTicks));
      Timer(
        duration,
        () {
          updateTracking();
          startPeriodicTimer();
        },
      );
    } else {
      startPeriodicTimer();
    }
  }

  void startPeriodicTimer() {
    timer = Timer.periodic(Duration(minutes: 1), (_) => updateTracking);
  }

  void resetStopwatches() {
    stopwatches.forEach((_, stopwatch) {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      }
      stopwatch.reset();
    });
  }

  void scheduleTrackedTimeReset() {
    getCurrentDate();
    final cron = Cron();
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      await saveCurrentData();
      initTrackedTime();

      getCurrentDate();
    });
  }

  void getCurrentDate() {
    currentYear = int.parse(DateFormat('y').format(DateTime.now()));
    currentMonth = DateFormat('y').format(DateTime.now()).toString();
    currentDay = int.parse(DateFormat('y').format(DateTime.now()));
  }

  void changeCurentActivity(Activity activity) {
    if (currentActivity == Activity.socialMedia ||
        currentActivity == Activity.sport) {
      stopwatches[Activity.leisure].stop();
    }
    stopwatches[currentActivity].stop();

    if (activity == Activity.socialMedia || activity == Activity.sport) {
      startStopwatch(stopwatches[Activity.leisure]);
    }
    startStopwatch(stopwatches[activity]);

    currentActivity = activity;
  }

  void updateTracking() {
    trackedTime.forEach(
      (key, value) {
        if (key == currentActivity) {
          value += 1;
        }
      },
    );
  }
}
