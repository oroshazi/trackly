import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/models/activity_model.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class TimerProvider extends ChangeNotifier {
  String _timeToDisplay = "00:00:00";

  final _stopwatch = new Stopwatch();
  final _duration = const Duration(seconds: 1);

  bool _isTimerRunning = false;
  bool _isSubTimerRunning = false;
  Duration _elapsedTimeInMainActivity = new Duration();

  get timeToDisplay {
    return _timeToDisplay;
  }

  get isTimerRunning {
    return _isTimerRunning;
  }

  get isSubTimerRunning {
    return _isSubTimerRunning;
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

    var elapsed = stopwatch.elapsed - _elapsedTimeInMainActivity;

    this._timeToDisplay = elapsed.inHours.toString().padLeft(2, "0") +
        ":" +
        (elapsed.inMinutes % 60).toString().padLeft(2, "0") +
        ":" +
        (elapsed.inSeconds % 60).toString().padLeft(2, "0");
    notifyListeners();
  }

  void start(BuildContext context) {
    _stopwatch.start();
    _startTimer(context);
  }

  void startSubActivity() {
    _isSubTimerRunning = true;
    _elapsedTimeInMainActivity = _stopwatch.elapsed;
  }

  void stopSubActivity(BuildContext context) {
    var _activityProvider =
        Provider.of<ActivityProvider>(context, listen: false);
    var activity = new Activity(
        duration: this.timeToDisplay,
        category: _activityProvider.selectedActivity);

    _activityProvider.finishActivity(activity);
    _activityProvider.removeSelectedActivity();
    _elapsedTimeInMainActivity = Duration();
    _isSubTimerRunning = false;
    notifyListeners();
  }

  void stop(BuildContext context) {
    var activityProvider =
        Provider.of<ActivityProvider>(context, listen: false);

    var activity = new Activity(
        duration: this.timeToDisplay,
        category: activityProvider.selectedActivity);

    activityProvider.finishActivity(activity);
    activityProvider.removeSelectedActivity();
    _stopwatch.reset();
    _stopwatch.stop();
    this.changeTimeToDisplay(_stopwatch);
  }

  void _startTimer(BuildContext context) {
    Timer(_duration, () => _keepCounting(context));
  }

  void _keepCounting(BuildContext context) {
    if (_stopwatch.isRunning) {
      this.changeTimeToDisplay(_stopwatch);
      _startTimer(context);
    }
  }
}
