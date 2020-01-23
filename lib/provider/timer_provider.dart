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
    _startTimer(context);
  }

  void stop(BuildContext context) {
    var activityProvider =
        Provider.of<ActivityProvider>(context, listen: false);
    var activity = new Activity(
        duration: this.timeToDisplay,
        category: activityProvider.selectedActivity);

    activityProvider.finishActivity(activity);
    activityProvider.removeSelectedActivity();
    _stopWatch.reset();
    _stopWatch.stop();
    Provider.of<TimerProvider>(context, listen: false)
        .changeTimeToDisplay(_stopWatch);
  }

  void _startTimer(BuildContext context) {
    Timer(_duration, () => _keepCounting(context));
  }

  void _keepCounting(BuildContext context) {
    if (_stopWatch.isRunning) {
      Provider.of<TimerProvider>(context, listen: false)
          .changeTimeToDisplay(_stopWatch);
      _startTimer(context);
    }
  }
}
