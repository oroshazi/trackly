import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  var _categoryList = [
    "Work",
    "Learning",
    "Cleaning",
    "Sport",
    "Entertainment",
    "Entertainment",
    "Entertainment",
    "Entertainment",
    "Entertainment",
    "Entertainment",
  ];

  // var _subCategoryWork = ["Meeting", "Research", "Perparation", "Programming"];

  get categoryList {
    return _categoryList;
  }
}
