import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        // TODO: here comes the create new thing
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
                          name: subCategoryName, parentId: mainActivity.id));

                  if (finished != null) {
                    Navigator.pop(context);
                  }
                }
              : (categoryName) async {
                  var finished = await Provider.of<CategoryProvider>(context,
                          listen: false)
                      .createNewCategory(Category(name: categoryName));

                  if (finished != null) {
                    Navigator.pop(context);
                  }
                },
          validator: (value) {
            if (value.length < 1) {
              return "field cannot be empty";
            }
            return null;
          },
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
                // TODO:
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
