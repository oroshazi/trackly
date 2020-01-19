import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';

PersistentBottomSheetController buildBottomSheet(BuildContext context) {
  final categoryList =
      Provider.of<CategoryProvider>(context, listen: false).categoryList;
  return showBottomSheet(
    backgroundColor: Colors.black12,
    context: context,
    builder: (context) {
      return Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  print("surface tapped");
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  width: double.infinity,
                )),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Provider.of<ActivityProvider>(context, listen: false)
                          .selectActivity(categoryList[index].toString());
                      Navigator.pop(context);
                    },
                    title: Text(categoryList[index].toString()),
                    dense: true,
                  );
                },
              ),
            ),
          )
        ],
      );
    },
  );
}
