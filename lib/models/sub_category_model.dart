import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/database_helper_models.dart';

class SubCategory extends Category {
  int id;
  int parentId;
  String name;

  SubCategory({this.name, this.id, this.parentId});

  SubCategory.fromJSON({Map json}) {
    this.id = json[Fields.COLUMN_ID];
    this.name = json[Fields.NAME];
    this.parentId = json[Fields.PARENT_CATEGORY_ID];
  }
}
