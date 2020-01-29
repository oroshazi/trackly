import 'package:flutter/foundation.dart';
import 'package:trackly_app/models/database_helper_models.dart';
import 'package:trackly_app/models/sub_category_model.dart';

class Category extends ChangeNotifier {
  int id;
  String name;
  List<SubCategory> _subCategoryList;

  Category({@required this.name, this.id});

  Category.fromJSON({Map<String, dynamic> json}) {
    var _fields = FieldNames();
    this.id = json[_fields.columnId];
    this.name = json[_fields.name];
  }
}
