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

  var _workSubCategories = [
    "Meeting",
    "Research",
    "Perparation",
    "Programming"
  ];

  // var _subCategoryWork = ["Meeting", "Research", "Perparation", "Programming"];

  get categoryList {
    return _categoryList;
  }

  get subCategoryListWork {
    return _workSubCategories;
  }

  // TODO:
  void createCategory() {}
  void createSubCategory(String parentCategory) {}
  void deleteCategory(int id) {}
  void updateCategory(id) {}
}
