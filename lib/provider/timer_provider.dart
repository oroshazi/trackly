import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  String _timeToDisplay = "00:00:00";
  bool _isTimerRunning = false;

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
}
