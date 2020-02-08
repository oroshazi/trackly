import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var data = [
      new Series(
        id: "1",
        data: Provider.of<ActivityProvider>(context).finishedActivities,
        domainFn: (Activity activity, _) => activity.category,
        measureFn: (Activity activity, _) => 1,
      )
    ];
    return SafeArea(
      bottom: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            child: SizedBox(child: PieChart(data), height: 200,),
          ),
          Card(
            child: Text("dashboard1"),
          ),
          Card(
            child: Text("dashboard1"),
          ),
        ],
      ),
    );
  }
}
