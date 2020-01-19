import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  LayoutWrapper(
                    child: Container(),
                  ),
                  LayoutWrapper(
                    child: ButtonStart(
                      enabled: Provider.of<ActivityProvider>(context)
                              .selectedActivity !=
                          null,
                      onPressed: () {
                        Provider.of<TimerProvider>(context, listen: false)
                            .start(context);
                      },
                    ),
                  ),
                  LayoutWrapper(
                    child: ButtonStop(
                      onPressed: () {
                        Provider.of<TimerProvider>(context, listen: false)
                            .stop(context);
                      },
                    ),
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
}

class LayoutWrapper extends StatelessWidget {
  final Widget child;
  LayoutWrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Align(alignment: Alignment.topLeft, child: this.child),
    );
  }
}
