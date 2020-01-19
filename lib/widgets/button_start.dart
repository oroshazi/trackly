import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/build_bottom_sheet.dart';

class ButtonStart extends StatelessWidget {
  final onPressed;
  final bool enabled;

  ButtonStart({@required this.onPressed, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: enabled ? Colors.green : Colors.grey,
      // mini: true, --> this will be cool for the stop button
      child: Text("strat"),
      onPressed: enabled ? onPressed : () => buildBottomSheet(context),
    );
  }
}
