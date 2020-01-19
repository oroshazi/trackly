import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String valueToDisplay = Provider.of<TimerProvider>(context).timeToDisplay;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              valueToDisplay,
              style: TextStyle(fontSize: 72),
            ),
          ),
          Text(Provider.of<ActivityProvider>(context).selectedActivity ??
              "",)
        ],
      ),
    );
  }
}
