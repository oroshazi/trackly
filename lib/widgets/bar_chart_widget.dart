import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class BartChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [
      new Series(
        id: DateTime.now().toString(),
        data: _groupSameActivityDurations(context),
        domainFn: (Activity activity, _) => activity.category,
        measureFn: (Activity activity, _) {
          return activity.duration.inSeconds;
        },
      )
    ];
    return Card(
      child: SizedBox(
        child: BarChart(
          data,
          domainAxis: new OrdinalAxisSpec(
            renderSpec: new SmallTickRendererSpec(
              // Tick and Label styling here.
              labelStyle: TextStyleSpec(
                  fontSize: 12, // size in Pts.
                  color: MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: LineStyleSpec(color: MaterialPalette.black),
            ),
          ),

          /// Assign a custom style for the measure axis.
          primaryMeasureAxis: new NumericAxisSpec(
            renderSpec: new GridlineRendererSpec(
              // Tick and Label styling here.
              labelStyle: new TextStyleSpec(
                fontSize: 18, // size in Pts.
                color: MaterialPalette.white,
              ),

              // Change the line colors to match text color.
              lineStyle: new LineStyleSpec(color: MaterialPalette.black),
            ),
          ),
        ),
        // height: 400,
      ),
    );
  }
}

_groupSameActivityDurations(BuildContext context) {
  var originalList =
      Provider.of<ActivityProvider>(context, listen: false).finishedActivities;
  List<Activity> newList = [];

  /// Create list with unique activites.
  for (var i = 0; i < originalList.length; i++) {
    newList.firstWhere((item) => item.category == originalList[i].category,
        orElse: () {
      newList.add(new Activity(
          category: originalList[i].category, duration: new Duration()));
      return null;
    });
  }

  /// Check if activity already on the list
  /// If yes add duration to the activity
  for (var i = 0; i < originalList.length; i++) {
    for (var l = 0; l < newList.length; l++) {
      if (originalList[i].category == newList[l].category) {
        newList[l].duration = originalList[i].duration + newList[l].duration;
      }
    }
  }

  return newList;
}
