import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/activity.dart';

class ButtonStatus extends ChangeNotifier {
  Map<Activity, bool> _buttonStatus = {
    Activity.sleep: false,
    Activity.work: false,
    Activity.leisure: false,
    Activity.sport: false,
    Activity.socialMedia: false,
    Activity.other: true,
  };

  // Map<Activity, bool> get buttonStatus {
  //   return {..._buttonStatus};
  // }

  bool getButtonStatus(Activity activity) {
    return _buttonStatus[activity]!;
  }

  void deactivateOtherButtons(Activity activity) {
    _buttonStatus.forEach((key, value) {
      if (key != activity) {
        _buttonStatus[key] = false;
      }
    });
    notifyListeners();
  }

  void changeButtonStatus(Activity activity) {
    _buttonStatus[activity] = !_buttonStatus[activity]!;
    if (_buttonStatus[activity]!) {
      switch (activity) {
        case Activity.sleep:
          deactivateOtherButtons(activity);
          break;
        case Activity.work:
          deactivateOtherButtons(activity);
          break;
        case Activity.leisure:
          deactivateOtherButtons(activity);
          break;
        case Activity.sport:
          deactivateOtherButtons(activity);
          _buttonStatus[Activity.leisure] = true;
          break;
        case Activity.socialMedia:
          deactivateOtherButtons(activity);
          _buttonStatus[Activity.leisure] = true;
          break;
        case Activity.other:
          deactivateOtherButtons(activity);
          break;
        default:
          break;
      }
    } else {
      switch (activity) {
        case Activity.sleep:
          _buttonStatus[Activity.other] = true;
          break;
        case Activity.work:
          _buttonStatus[Activity.other] = true;
          break;
        case Activity.leisure:
          _buttonStatus[Activity.sport] = false;
          _buttonStatus[Activity.socialMedia] = false;
          _buttonStatus[Activity.other] = true;
          break;
        case Activity.sport:
          _buttonStatus[Activity.leisure] = false;
          _buttonStatus[Activity.other] = true;
          break;
        case Activity.socialMedia:
          _buttonStatus[Activity.leisure] = false;
          _buttonStatus[Activity.other] = true;
          break;
        case Activity.other:
          _buttonStatus[Activity.other] = true;
          break;
        default:
          break;
      }
    }
    notifyListeners();
  }
}
