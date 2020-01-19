import 'package:flutter/material.dart';

class Activity {
  String category;
  String subCategory;
  String duration;
  String notes;

  Activity(
      {@required this.category,
      @required this.duration,
      this.subCategory,
      this.notes});
}
