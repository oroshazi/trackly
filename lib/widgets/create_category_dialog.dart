import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/helpers/capitilize.dart';
import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/sub_category_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';

class CreateCategoryDialog extends StatelessWidget {
  const CreateCategoryDialog({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.isSubCategoryList,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final bool isSubCategoryList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create new category"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          onSaved: isSubCategoryList
              ? (subCategoryName) async {
                  var mainActivity =
                      Provider.of<ActivityProvider>(context, listen: false)
                          .runningMainActicity;

                  var finished = await Provider.of<CategoryProvider>(context,
                          listen: false)
                      .createNewSubCategory(SubCategory(
                          name: capitalize(subCategoryName),
                          parentId: mainActivity.id));

                  if (finished != null) {
                    Navigator.pop(context);
                  }
                }
              : (categoryName) async {
                  var finished = await Provider.of<CategoryProvider>(context,
                          listen: false)
                      .createNewCategory(
                          Category(name: capitalize(categoryName)));

                  if (finished != null) {
                    Navigator.pop(context);
                  }
                },
          validator: (value) =>
              validateInput(value, isSubCategoryList, context),
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

validateInput(String value, bool isSubCategoryList, BuildContext context) {
  if (value.length < 1) {
    return "field cannot be empty";
  }

  if (isSubCategoryList) {
    var subCat = Provider.of<CategoryProvider>(context, listen: false)
        .subCategoryList(
            parentCategoryName:
                Provider.of<ActivityProvider>(context, listen: false)
                    .runningMainActicity
                    .category);
    var match =
        subCat.firstWhere((item) => item.name == value, orElse: () => null);
    if (match != null) {
      return "Category already exists";
    }
  }

  if (!isSubCategoryList) {
    var cat =
        Provider.of<CategoryProvider>(context, listen: false).categoryList;
    var match =
        cat.firstWhere((item) => item.name == value, orElse: () => null);
    if (match != null) {
      return "Category already exists";
    }
  }

  return null;
}
