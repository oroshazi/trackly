import 'package:flutter/material.dart';

class CurrentTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentTime = DateTime.now().toString(); 
    return Container(
      child: Text(currentTime),
    );
  }
}