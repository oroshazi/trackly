import 'package:flutter/foundation.dart';
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

  get subCategories async {}
}
