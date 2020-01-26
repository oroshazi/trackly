import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/database_helper.dart';
import 'package:trackly_app/models/activity_model.dart';

class ActivityProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;

  List<Activity> _finishedActivites = [];
  String _selectedActivity;

  get finishedActivities {
    _queryActivites();
    return _finishedActivites;
  }

  get selectedActivity {
    return _selectedActivity;
  }

  void selectActivity(String activity) {
    _selectedActivity = activity;
    notifyListeners();
  }

  void removeSelectedActivity() {
    _selectedActivity = null;
    notifyListeners();
  }

  void finishActivity(Activity activity) async {
    var queryResult;
    // Insert finished activity to the first place of the list
    _finishedActivites.insert(0, activity);

    try {
      queryResult = await _dbHelper.insert({
        DatabaseHelper.currentDate: DateTime.now().toString(),
        DatabaseHelper.currentTime: DateTime.now().toString(),
        DatabaseHelper.category: activity.category,
        DatabaseHelper.duration: activity.duration,
        DatabaseHelper.notes: activity.notes,
        DatabaseHelper.subCategory: activity.subCategory,
      });
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
      allRows = await _dbHelper.queryAllRows();
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
