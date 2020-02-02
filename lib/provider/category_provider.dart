import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/database_helper.dart';
import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';
import 'package:trackly_app/models/sub_category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final _dbHelper = DatabaseHelper.instance;
  var _fields = new FieldNames();
  var _tables = new TableNames();

  List<Category> _categoryList = [];
  List<SubCategory> _subCategoryList = [];

  // List<Category> _categoryListToDisplay = [];

  List<Category> get categoryList {
    _queryCategoryList();
    return _categoryList;
  }

  List<SubCategory> subCategoryList({@required String parentCategoryName}) {
    if (parentCategoryName != null) {
      _querySubCategoryList(parentCategoryName: parentCategoryName);
    }
    return _subCategoryList;
  }

  Future<int> createNewCategory(Category category) async {
    var _queryResult;
    try {
      _queryResult = _queryResult = await _dbHelper
          .insert({_fields.name: category.name}, _tables.categories);

      if (_queryResult != null) {
        await _queryCategoryList();
      }
    } catch (e) {
      print(e);
      throw Error;
    }
    return _queryResult;
  }

  Future<int> createNewSubCategory(SubCategory subCategory) async {
    var _queryResult;
    try {
      _queryResult = _queryResult = await _dbHelper.insert({
        _fields.name: subCategory.name,
        _fields.parentCategoryId: subCategory.parentId
      }, _tables.subCategories);

      if (_queryResult != null) {
        await _querySubCategoryList(parentCategoryId: subCategory.parentId);
      }
    } catch (e) {
      print(e);
      throw Error;
    }
    return _queryResult;
  }

  Future<void> _queryCategoryList() async {
    // print("_queryCategoryList called");
    List<Map<String, dynamic>> allRows;
    List<Category> categoryList = [];
    try {
      allRows = await _dbHelper.queryAllRows(_tables.categories);
      for (var i = 0; i < allRows.length; i++) {
        categoryList.add(Category.fromJSON(json: allRows[i]));
      }

      if (categoryList.length != _categoryList.length) {
        _categoryList = categoryList;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw Error;
    }
  }

  Future<void> _querySubCategoryList(
      {String parentCategoryName, int parentCategoryId}) async {
    var _id;
    List<SubCategory> subCategoryList = [];
    List<Map<String, dynamic>> _queryResult;

    if (parentCategoryId == null) {
        print("parentCategoryID"); 
        print(parentCategoryId); 
      try {
        print("parentCategoryName"); 
        print(parentCategoryName); 
        _id = await _getCategoryIdByName(parentCategoryName);

        if (_id == null) {
          print("id not found");
          return this._subCategoryList;
        }
      } catch (e) {
        throw Error;
      }
    } else {
      _id = parentCategoryId;
    }

    try {
      _queryResult = await _dbHelper.rawQuery(''' 
       SELECT * FROM ${_tables.subCategories} WHERE ${_fields.parentCategoryId} = $_id;
       ''');

      for (var i = 0; i < _queryResult.length; i++) {
        subCategoryList.add(SubCategory.fromJSON(json: _queryResult[i]));
      }

      if (_subCategoryList.length != subCategoryList.length) {
        print(subCategoryList.last.name);
        _subCategoryList = subCategoryList;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw Error;
    }
  }

  Future<int> _getCategoryIdByName(String name) async {
    var _queryResult;
    int _categoryId;

    try {
      _queryResult = await _dbHelper.rawQuery(''' 
       SELECT ${_fields.columnId} FROM ${_tables.categories} WHERE ${_fields.name} = "$name";
       ''');
      if (_queryResult.length == 0) {
        print(_queryResult);
        return _categoryId = null;
      }
      _categoryId = _queryResult[0][_fields.columnId];
    } catch (e) {
      print(e);
      throw Error;
    }

    return _categoryId;
  }
}

// List<Category> categoryListToDisplay(String selectedCategory) {
//   if (selectedCategory == null) {
//     _categoryListToDisplay = this.categoryList;
//     notifyListeners();
//     return _categoryListToDisplay;
//   }
//   if (selectedCategory != null &&
//       _categoryListToDisplay is! List<SubCategory>) {
//     _categoryListToDisplay =
//         this.subCategoryList(name: selectedCategory);
//     notifyListeners();
//     return _categoryListToDisplay;
//   }
//   if (_categoryListToDisplay is List<SubCategory>) {
//     print("_categoryListToDisplay is List<SubCategory>");
//     print(_categoryListToDisplay is List<SubCategory>);
//     return _categoryListToDisplay;
//   }
//   return _categoryListToDisplay;
// }
