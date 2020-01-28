import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/database_helper.dart';
import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class CategoryProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;
  var _fields = new FieldNames();
  var _tables = new TableNames();

  List<Category> _categoryList = [];

  var _workSubCategories = [
    "Meeting",
    "Research",
    "Perparation",
    "Programming"
  ];

  // var _subCategoryWork = ["Meeting", "Research", "Perparation", "Programming"];

  List<Category> get categoryList {
    _queryCategoryList();
    return _categoryList;
  }

  get subCategoryListWork {
    return _workSubCategories;
  }

  void _queryCategoryList() async {
    List<Map<String, dynamic>> allRows;
    List<Category> categoryList = [];
    try {
      allRows = await _dbHelper.queryAllRows(_tables.categories);
      for (var i = 0; i < allRows.length; i++) {
        categoryList.add(Category.fromJSON(json: allRows[i]));
      }
      if (categoryList.length != _categoryList.length) {
        print("_queryCategoryList called notifyListeners"); 
        notifyListeners();
      }
      _categoryList = categoryList;
    } catch (e) {
      print(e);
      throw Error;
    }
  }

  // TODO:
  void createCategory() {}
  void createSubCategory(String parentCategory) {}
  void deleteCategory(int id) {}
  void updateCategory(id) {}
}
