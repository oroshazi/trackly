import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/build_bottom_sheet.dart';

class ButtonStart extends StatelessWidget {
  final onPressed;
  final bool enabled;

  ButtonStart({@required this.onPressed, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 130.0,
      child: new RawMaterialButton(
        fillColor: enabled ? Colors.green : Colors.grey,
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Icon(Icons.play_arrow),
        onPressed: enabled ? onPressed : () => buildBottomSheet(context),
      ),
    );
  }
}
