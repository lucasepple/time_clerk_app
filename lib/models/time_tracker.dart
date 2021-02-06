import 'dart:async';

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
  Map<Activity, int> trackedTime;
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

  void initTrackedTime() {
    trackedTime = {
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
          trackedTime[activity];
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
