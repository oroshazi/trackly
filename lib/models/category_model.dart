import 'package:flutter/foundation.dart';
import 'package:trackly_app/models/database_helper_models.dart';
// import 'package:trackly_app/models/sub_category_model.dart';

class Category {
  int id;
  String name;

  Category({@required this.name, this.id});

  Category.fromJSON({Map<String, dynamic> json}) {
    this.id = json[Fields.COLUMN_ID];
    this.name = json[Fields.NAME];
  }
}
