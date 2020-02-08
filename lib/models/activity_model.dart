import 'package:flutter/material.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class Activity {
  int id;
  String category;
  String subCategory;
  // TODO: this should be Duration()
  String duration;
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
    this.duration = json[fields.duration];
    this.notes = json[fields.notes];
    this.date = json[fields.date];
    this.time = json[fields.time];
  }
}
