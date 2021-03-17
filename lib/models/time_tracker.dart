import 'dart:async';

import 'package:cron/cron.dart';
import 'package:intl/intl.dart';

import 'package:time_clerk_app/models/activity.dart';

class TimeTracker {
  int? currentYear;
  String? currentMonth;
  int? currentDay;
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

  Map<Activity, Stopwatch> stopwatches = {
    Activity.sleep: Stopwatch(),
    Activity.work: Stopwatch(),
    Activity.leisure: Stopwatch(),
    Activity.sport: Stopwatch(),
    Activity.socialMedia: Stopwatch(),
    Activity.other: Stopwatch(),
  };
  Timer? timer;
  // initted for dev
  Map<Activity, Map<int?, Map<String?, Map<int?, int?>>>> _storedData = {
    Activity.sleep: {
      2021: {
        'January': {
          1: 530,
        },
        'February': {
          1: 540,
          2: 400,
          3: 300,
          4: 400,
          5: 500,
          6: 340,
          7: 400,
          8: 200,
          9: 400,
          10: 300,
          11: 400,
          12: 500,
          13: 300,
          14: 400,
          15: 540,
          16: 400,
          17: 300,
          18: 400,
          19: 500,
          20: 340,
          21: 400,
          22: 200,
          23: 400,
          24: 300,
          25: 400,
          26: 500,
          27: 300,
          28: 400,
          29: 470,
          30: 370,
          31: 510,
        },
        'March': {
          1: 330,
        },
        'April': {
          1: 430,
        },
        'May': {
          1: 470,
        },
        'June': {
          1: 450,
        },
        'July': {
          1: 480,
        },
        'August': {
          1: 450,
        },
        'September': {
          1: 410,
        },
        'October': {
          1: 450,
        },
        'November': {
          1: 480,
        },
        'December': {
          1: 340,
        },
      },
    },
    Activity.work: {},
    Activity.leisure: {},
    Activity.sport: {},
    Activity.socialMedia: {},
    Activity.other: {},
  };

  Map<Activity, int> get trackedTime {
    return {..._trackedTime};
  }

  Map<Activity, Map<int?, Map<String?, Map<int?, int?>>>> get storedData {
    return {..._storedData};
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

// combine with yearly Avg
  double monthlyAvg(int year, String? month, Activity? activity) {
    double avg = 0;
    int totalTime = 0;
    int amount = 0;
    if (TimeTracker().storedData[activity!]![year] != null) {
      _storedData[activity]![year]![month]!.forEach(
        (day, minutes) {
          totalTime += minutes!;
          amount++;
        },
      );
    }
    if (totalTime != 0) {
      avg = totalTime / amount;
    }
    return avg;
  }

// combine wth monthlyAvg
  double yearlyAvg(int year, Activity activity) {
    double avg = 0;
    int totalTime = 0;
    int amount = 0;
    if (TimeTracker().storedData[activity]![year] != null) {
      _storedData[activity]![year]!.forEach(
        (month, daysMap) {
          daysMap.forEach(
            (day, minutes) {
              totalTime += minutes!;
              amount++;
            },
          );
        },
      );
    }
    if (totalTime != 0) {
      avg = totalTime / amount;
    }
    return avg;
  }

  void setTimeLimit(String day, Activity activity, int minutes) {
    _timeLimits[day]!.update(
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
      if (!_storedData[activity]!.containsKey(currentYear)) {
        _storedData[activity]![currentYear] = {};
      }
      if (!_storedData[activity]![currentYear]!.containsKey(currentMonth)) {
        _storedData[activity]![currentYear]![currentMonth] = {};
      }
      _storedData[activity]![currentYear]![currentMonth]![currentDay] =
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
      stopwatches[Activity.leisure]!.stop();
    }
    stopwatches[currentActivity]!.stop();

    if (activity == Activity.socialMedia || activity == Activity.sport) {
      startStopwatch(stopwatches[Activity.leisure]!);
    }
    startStopwatch(stopwatches[activity]!);

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
