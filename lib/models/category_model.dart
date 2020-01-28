import 'package:flutter/foundation.dart';
import 'package:trackly_app/models/database_helper_models.dart';
import 'package:trackly_app/models/sub_category_model.dart';

///
/// Goal: Category("Work").subCategories = ["Meeting", "valami mas" etc];
///
///
///
class Category {
  String name;
  List<SubCategory> _subCategories;

  Category({@required this.name});

  Category.fromJSON({Map<String, dynamic> json}) {
    var _fields = FieldNames(); 
    this.name = json[_fields.name];
  }

  get subCategories async {}
}
