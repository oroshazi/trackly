import 'package:flutter/material.dart';
import 'package:trackly_app/widgets/activity_list_widget.dart';
import 'package:trackly_app/widgets/bar_chart_widget.dart';
import 'package:trackly_app/widgets/layout_wrapper.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LayoutWrapper(
            flex: 2,
            child: BartChartWidget(),
          ),
          LayoutWrapper(child: ActivityListWidget())
        ],
      ),
    );
  }
}
