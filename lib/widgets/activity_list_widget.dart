import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class ActivityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        List<Activity> activityList =
            Provider.of<ActivityProvider>(context).finishedActivities;

        return Container(
          // height: 100,
          child: ListView.builder(
            itemCount: activityList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(activityList[index].category),
                    trailing: Text(activityList[index].duration),
                    dense: true,
                  ),
                  Divider()
                ],
              );
            },
          ),
        );
      },
    );
  }
}
