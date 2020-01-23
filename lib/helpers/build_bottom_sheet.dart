import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/widgets/list_tile_widget.dart';

///
///if  [isOpenedWihButton] = true counter starts
///after clicking on the element in the list.
///[context] pass the context of the screen if you want to do changes from the bottom sheet on that screen
///
PersistentBottomSheetController buildBottomSheet(BuildContext context,
    {bool isOpenedWithButton = false}) {
  final categoryList =
      Provider.of<CategoryProvider>(context, listen: false).categoryList;
  return showBottomSheet(
    backgroundColor: Colors.black12,
    context: context,
    builder: (_) {
      return Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: GestureDetector(
                onTap: () {
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
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0))),
              child: ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ListTileWidget(
                    onTap: () {
                      Provider.of<ActivityProvider>(context, listen: false)
                          .selectActivity(categoryList[index].toString());
                      if (isOpenedWithButton) {
                        Provider.of<TimerProvider>(context, listen: false)
                            .start(context);
                      }
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
