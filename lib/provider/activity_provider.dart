import 'package:flutter/material.dart';
import 'package:trackly_app/models/activity_model.dart';

class ActivityProvider extends ChangeNotifier {
  List<Activity> _finishedActivites = [];
  String _selectedActivity;

  get finishedActivities {
    return _finishedActivites;
  }

  get selectedActivity {
    return _selectedActivity;
  }

  void selectActivity(String activity) {
    _selectedActivity = activity;
    notifyListeners();
  }

  void finishActivity(Activity activity) {
    // Insert finished activity to the first place of the list
    _finishedActivites.insert(0, activity);
    notifyListeners();
  }
}
