import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/category_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/widgets/list_tile_widget.dart';

///
///if  [isOpenedWihButton] = true counter starts
///after clicking on the element in the list.
///[context] pass the context of the screen if you want to do changes from the bottom sheet on that screen
///
buildBottomSheet(BuildContext context, {bool isOpenedWithButton = false}) {
  return showModalBottomSheet(
    backgroundColor: Colors.black12,
    context: context,
    builder: (_) {
      final categoryList =
          Provider.of<CategoryProvider>(context, listen: false).categoryList;
      return Container(
        height: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
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
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Create new category"),
                              content: Form(
                                // TODO: here comes the create new thing
                                child: TextFormField(),
                              ),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                  )),
                ],
              ),
            ),
            Divider(),
            Flexible(
              flex: 1,
              child: Container(
                child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ListTileWidget(
                      onTap: () {
                        Provider.of<ActivityProvider>(context, listen: false)
                            .selectActivity(categoryList[index].name);
                        if (isOpenedWithButton) {
                          Provider.of<TimerProvider>(ctx, listen: false)
                              .start(context);
                        }
                        Navigator.pop(context);
                      },
                      title: Text(categoryList[index].name),
                      dense: true,
                    );
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

List<Category> _selectCategory(BuildContext context) {
  var _catProv = Provider.of<CategoryProvider>(context);
  var _actProv = Provider.of<ActivityProvider>(context);

  if (_actProv.selectedActivity != null) {
    return Category(name: _actProv.selectedActivity).subCategories;
  }
  return _catProv.categoryList;
}
