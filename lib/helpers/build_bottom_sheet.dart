import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/models/sub_category_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/widgets/list_tile_widget.dart';

///if  [isOpenedWihButton] = true counter starts
///after clicking on the element in the list.
///[context] pass the context of the screen if you want to do changes from the bottom sheet on that screen
buildBottomSheet(BuildContext context, {bool isOpenedWithButton = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.black12,
    context: context,
    builder: (_) {
      return Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, right: 15, left: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Container(
                    child: Text(
                      "Select an activity",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                      child: GestureDetector(
                    child: Icon(Icons.add),
                    onTap: () async {
                      await _buildShowDialog(context);
                    },
                  )),
                ],
              ),
            ),
            Divider(),
            Flexible(
              flex: 1,
              child: Container(
                child: Builder(
                  builder: (BuildContext _) {
                    return Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        var categoryList = _buildCategoryListToShow(context);
                        return ListView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            // print("ListView rebuilt");
                            bool isSubCategoryList =
                                categoryList is List<SubCategory>;

                            return ListTileWidget(
                              onTap: () {
                                final activity = Provider.of<ActivityProvider>(
                                    context,
                                    listen: false);
                                activity
                                    .selectActivity(categoryList[index].name);

                                if (isOpenedWithButton && !isSubCategoryList) {
                                  Provider.of<TimerProvider>(ctx, listen: false)
                                      .start(context);
                                  Navigator.pop(context);
                                }

                                if (isOpenedWithButton && isSubCategoryList) {
                                  Provider.of<TimerProvider>(ctx, listen: false)
                                      .startSubActivity();
                                  Navigator.pop(context);
                                }
                              },
                              title: Text(categoryList[index].name),
                              dense: true,
                            );
                          },
                        );
                      },
                    );

                    // return
                  },
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

_buildShowDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = new GlobalKey<FormState>();
        var categoryType = _buildCategoryListToShow(context);

        bool isSubCategoryList = categoryType is List<SubCategory>;

        return AlertDialogWidget(
            formKey: _formKey, isSubCategoryList: isSubCategoryList);
      });
}

List<Category> _buildCategoryListToShow(BuildContext context) {
  var mainCategoryList = Provider.of<CategoryProvider>(context).categoryList;
  var subCategoryList = Provider.of<CategoryProvider>(context).subCategoryList(
      name: Provider.of<ActivityProvider>(context).selectedActivity);
  var categoryList =
      Provider.of<ActivityProvider>(context).selectedActivity == null
          ? mainCategoryList
          : subCategoryList;
  return categoryList;
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
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
              ? (value) => print("lolller subcategory" + value)
              : (categoryName) async {
                  print(categoryName.toUpperCase());
                  var finished = await Provider.of<CategoryProvider>(context,
                          listen: false)
                      .createNewCategory(Category(name: categoryName));

                  if (finished != null) {
                    Navigator.pop(context);
                  }
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
                _formKey.currentState.validate();
                _formKey.currentState.save();
              },
            ),
          ],
        ),
      ],
    );
  }
}
