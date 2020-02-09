import 'package:flutter/material.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class Activity {
  int id;
  String category;
  String subCategory;
  // TODO: this should be Duration()
  Duration duration;
  String notes;
  String time;
  String date;

  Activity(
      {this.id,
      @required this.category,
      this.duration,
      this.date,
      this.time,
      this.subCategory,
      this.notes});

  Activity.fromJSON({Map<String, dynamic> json}) {
    var fields = FieldNames();
    this.id = json[fields.columnId];
    this.category = json[fields.category].toString();
    this.subCategory = json[fields.subCategory];
    this.duration = this.stringToDuration(json[fields.duration]);
    this.notes = json[fields.notes];
    this.date = json[fields.date];
    this.time = json[fields.time];
  }

  Duration stringToDuration(String durationInString) {
    var _durationInDuration;

    // Format: 0:00:04.0000
    var h = int.parse(durationInString.split(":")[0]);
    var m = int.parse(durationInString.split(":")[1]);
    var s = int.parse(durationInString.split(":")[2].split(".")[0]);
    // var ms = int.parse(durationInString.split(":")[2].split(".")[1]);

    _durationInDuration = new Duration(
      hours: h,
      minutes: m,
      seconds: s,
    );
    return _durationInDuration;
  }
}
