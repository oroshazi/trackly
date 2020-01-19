import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String valueToDisplay = Provider.of<TimerProvider>(context).timeToDisplay;

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(valueToDisplay, style: TextStyle(fontSize: 72),),
          ),
          // RaisedButton(
          //   child: Text("start"),
          //   onPressed: () => this.start(context),
          // ),
          // RaisedButton(
          //   child: Text("stop"),
          //   onPressed: () => this.stop(context),
          // ),
          // RaisedButton(child: Text("valami"), onPressed: () {}),
        ],
      ),
    );
  }


  
}
