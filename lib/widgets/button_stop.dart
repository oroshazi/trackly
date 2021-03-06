import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';

class ButtonStop extends StatelessWidget {
  final onPressed;

  ButtonStop({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var isTimerRunning = Provider.of<TimerProvider>(context).isTimerRunning;
    return isTimerRunning
        ? FloatingActionButton(
            backgroundColor: Colors.orange,
            mini: true,
            child: Icon(Icons.stop),
            onPressed: onPressed,
          )
        : Container();
  }
}
