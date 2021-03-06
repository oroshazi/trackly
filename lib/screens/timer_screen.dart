import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/helpers/build_bottom_sheet.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/widgets/activity_list_widget.dart';
import 'package:trackly_app/widgets/button_start.dart';
import 'package:trackly_app/widgets/button_stop.dart';
import 'package:trackly_app/widgets/layout_wrapper.dart';
import 'package:trackly_app/widgets/timer_widget.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({
    Key key,
    @required this.scaffold,
  });

  final GlobalKey scaffold;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                LayoutWrapper(
                  child: Container(),
                ),
                LayoutWrapper(
                  child: ButtonStart(
                    // foreignContext: _scaffold.currentContext,
                    enabled: Provider.of<ActivityProvider>(context)
                            .selectedActivity.category !=
                        null,
                    onPressed: () {
                      Provider.of<TimerProvider>(context, listen: false)
                          .start(context);
                    },
                    bottomSheetBuilder: () {
                      buildBottomSheet(scaffold.currentContext,
                          isOpenedWithButton: true);
                    },
                  ),
                ),
                LayoutWrapper(
                  child: ButtonStop(
                    onPressed: () {
                      var p =
                          Provider.of<TimerProvider>(context, listen: false);

                      p.isSubTimerRunning
                          ? p.stopSubActivity(context)
                          : p.stop(context);

                      /**
                       * Use [{listen:false}] if a function is needed to be executed
                       * Don't use it if you are listenting to a value
                       */
                    },
                  ),
                ),
              ],
            ),
          ),
          /**
           * FIXME: Not sure if its needed or not
           */
          // SafeArea(
          //   bottom: true,
          //   child: SelectCategoryWidget(
          //     selectedCagetory:
          //         Provider.of<ActivityProvider>(context).selectedActivity,
          //   ),
          // ),
        ],
      ),
    );
  }
}
