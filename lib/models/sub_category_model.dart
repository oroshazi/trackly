import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class SubCategory extends Category {
  int id;
  int parentId;
  String name;

  SubCategory({this.name, this.id, this.parentId});

  SubCategory.fromJSON({Map json}) {
    var _f = FieldNames();
    this.id = json[_f.columnId];
    this.name = json[_f.name];
    this.parentId = json[_f.parentCategoryId];
  }
}
