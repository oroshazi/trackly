import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class TimerProvider extends ChangeNotifier {
  String _timeToDisplay = "00:00:00";
  bool _isTimerRunning = false;
  final _duration = const Duration(milliseconds: 1);
  final _stopWatch = Stopwatch();

  get timeToDisplay {
    return _timeToDisplay;
  }

  get isTimerRunning {
    return _isTimerRunning;
  }

  void changeTimeToDisplay(Stopwatch stopwatch) {
    if (stopwatch.isRunning) {
      _isTimerRunning = true;
      notifyListeners();
    }
    if (!stopwatch.isRunning) {
      _isTimerRunning = false;
      notifyListeners();
    }
    var elapsed = stopwatch.elapsed;
    this._timeToDisplay = stopwatch.elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (elapsed.inSeconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }

  void start(BuildContext context) {
    _stopWatch.start();
    startTimer(context);
  }

  void stop(BuildContext context) {
    var activity = new Activity(
        duration: this.timeToDisplay,
        category: Provider.of<ActivityProvider>(context, listen: false)
            .selectedActivity);
    Provider.of<ActivityProvider>(context, listen: false)
        .finishActivity(activity);
    _stopWatch.reset();
    _stopWatch.stop();
    // _stopWatch.
    Provider.of<TimerProvider>(context, listen: false)
        .changeTimeToDisplay(_stopWatch);
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
