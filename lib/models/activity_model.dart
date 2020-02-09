import 'package:flutter/material.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class Activity {
  int id;
  String category;
  String subCategory;
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
    this.id = json[Fields.COLUMN_ID];
    this.category = json[Fields.CATEGORY].toString();
    this.subCategory = json[Fields.SUB_CATEGORY];
    this.duration = this._stringToDuration(json[Fields.DURATION]);
    this.notes = json[Fields.NOTES];
    this.date = json[Fields.DATE];
    this.time = json[Fields.TIME];
  }

  Duration _stringToDuration(String durationInString) {
    var _durationInDuration;

    // Duration saved in this format: 0:00:04.0000
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
