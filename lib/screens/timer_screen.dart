import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/widgets/activity_list_widget.dart';
import 'package:trackly_app/widgets/button_start.dart';
import 'package:trackly_app/widgets/button_stop.dart';
import 'package:trackly_app/widgets/select_category_widget.dart';
import 'package:trackly_app/widgets/timer_widget.dart';

class TimerScreen extends StatefulWidget {
  final static = "/timer-screen";
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final _duration = const Duration(seconds: 1);
  final _stopWatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LayoutWrapper(child: TimerWidget()),
            LayoutWrapper(child: ActivityListWidget()),
            LayoutWrapper(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonStart(
                    enabled: Provider.of<ActivityProvider>(context)
                            .selectedActivity !=
                        null,
                    onPressed: () {
                      start(context);
                    },
                  ),
                  ButtonStop(
                    onPressed: () {
                      this.stop(context);
                    },
                  ),
                ],
              ),
            ),
            SelectCategoryWidget(
              selectedCagetory:
                  Provider.of<ActivityProvider>(context).selectedActivity,
            ),
            // SafeArea(bottom: true,)
          ],
        ),
      ),
    );
  }

  void start(BuildContext context) {
    _stopWatch.start();
    startTimer(context);
  }

  void stop(BuildContext context) {
    var activity = new Activity(
        duration:
            Provider.of<TimerProvider>(context, listen: false).timeToDisplay,
        category: Provider.of<ActivityProvider>(context, listen: false)
            .selectedActivity);
    Provider.of<ActivityProvider>(context, listen: false)
        .finishActivity(activity);
    _stopWatch.reset();
    _stopWatch.stop();
    // _stopWatch.
    Provider.of<TimerProvider>(context, listen: false).changeTimeToDisplay(_stopWatch);
  }

  void startTimer(BuildContext context) {
    Timer(_duration, () => keepCounting(context));
  }

  void keepCounting(BuildContext context) {
    if (_stopWatch.isRunning) {
      // print(_stopWatch.isRunning);
      Provider.of<TimerProvider>(context, listen: false)
          .changeTimeToDisplay(_stopWatch);
      startTimer(context);
    }
  }
}

class LayoutWrapper extends StatelessWidget {
  final Widget child;
  LayoutWrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Align(child: this.child),
    );
  }
}
