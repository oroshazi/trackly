import 'package:flutter/material.dart';

class Activity {
  String id;
  String category;
  String subCategory;
  String duration;
  String notes;
  String time;
  String date;

  Activity(
      {this.id,
      @required this.category,
      @required this.duration,
      @required this.date,
      @required this.time,
      this.subCategory,
      this.notes});

  Activity.fromJSON({Map<String, dynamic> json}) {
    this.id = json["_id"].toString();
    this.category = json["category"].toString();
    this.subCategory = json["subCategory"];
    this.duration = json["duration"];
    this.notes = json["notes"];
    this.date = json["date"];
    this.time = json["time"];
  }
}
