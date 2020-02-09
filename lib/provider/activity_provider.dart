import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/database_helper.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class ActivityProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;

  List<Activity> _finishedActivites = [];
  List<Activity> _selectedActivityList = [];

  List<Activity> get finishedActivities {
    _queryActivites();
    return _finishedActivites;
  }

  Activity get selectedActivity {
    if (_selectedActivityList.length != 0) return _selectedActivityList.last;
    return Activity(category: null);
  }

  Activity get runningMainActicity {
    if (_selectedActivityList.length != 0) {
      return _selectedActivityList.first;
    }
    return Activity(category: null);
  }

  void selectActivity(Activity activity) {
    _selectedActivityList.add(activity);
    notifyListeners();
  }

  void removeSelectedActivity() {
    _selectedActivityList.removeLast();
    notifyListeners();
  }

  void finishActivity(Activity activity) async {
    var queryResult;

    // Insert finished activity to the first place of the list
    _finishedActivites.insert(0, activity);

    try {
      queryResult = await _dbHelper.insert({
        Fields.DATE: DateTime.now().toString(),
        Fields.TIME: DateTime.now().toString(),
        Fields.CATEGORY: activity.category,
        Fields.DURATION: activity.duration.toString(),
        Fields.NOTES: activity.notes,
        Fields.SUB_CATEGORY: activity.subCategory,
      }, Tables.ACTIVITIES);
      if (queryResult == null) print("error, while inserting.");
    } catch (e) {
      print(e);
      throw Error;
    }
    notifyListeners();
  }

  void _queryActivites() async {
    List<Map<String, dynamic>> allRows;
    List<Activity> activityList = [];
    try {
      allRows = await _dbHelper.queryAllRows(Tables.ACTIVITIES);
      for (var i = 0; i < allRows.length; i++) {
        activityList.add(Activity.fromJSON(json: allRows[i]));
      }

      /// Notify listeners only if there is a difference
      /// between activity list in memory and activity list
      /// in database.
      if (activityList.length != _finishedActivites.length) {
        notifyListeners();
      }
      _finishedActivites = activityList;
    } catch (e) {
      print(e);
      throw Error;
    }
  }
}
