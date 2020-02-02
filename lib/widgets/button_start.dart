import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/activity_provider.dart';

class ButtonStart extends StatelessWidget {
  final onPressed;
  final bottomSheetBuilder;
  final bool enabled;

  ///[foreignKey] needed if context is needed from a different screen.
  ///e.g. If you want to start the timer on timer screen, from the bottomActivitySheet.
  // final BuildContext foreignContext;

  ButtonStart(
      {@required this.onPressed,
      @required this.enabled,
      // this.foreignContext,
      this.bottomSheetBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 130.0,
      child: new RawMaterialButton(
        fillColor: enabled ? Colors.green : Colors.grey,
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Provider.of<ActivityProvider>(context).selectedActivity.category == null
            ? Icon(Icons.play_arrow)
            : Icon(Icons.add),
        onPressed: bottomSheetBuilder,
      ),
    );
  }
}
