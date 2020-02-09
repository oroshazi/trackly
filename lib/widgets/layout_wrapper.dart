import 'package:flutter/material.dart';

class LayoutWrapper extends StatelessWidget {
  final Widget child;
  final int flex;
  LayoutWrapper({@required this.child, this.flex});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: this.flex == null ? 1 : flex,
      child: Align(alignment: Alignment.topLeft, child: this.child),
    );
  }
}
