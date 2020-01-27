import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/database_helper.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class ActivityProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;
  var _fields = new FieldNames();
  var _tables = new TableNames();

  List<Activity> _finishedActivites = [];
  String _selectedActivity;

  get finishedActivities {
    _queryActivites();
    return _finishedActivites;
  }

  String get selectedActivity {
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
        _fields.date: DateTime.now().toString(),
        _fields.time: DateTime.now().toString(),
        _fields.category: activity.category,
        _fields.duration: activity.duration,
        _fields.notes: activity.notes,
        _fields.subCategory: activity.subCategory,
      }, _tables.activities);
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
      allRows = await _dbHelper.queryAllRows(_tables.activities);
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
