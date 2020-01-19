import 'package:flutter/material.dart';

class ListTileWidget extends ListTile {
  final title; 
  final onTap; 
  final dense; 

  ListTileWidget({this.title, this.onTap, this.dense}); 

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        onTap: this.onTap,
        dense: this.dense,
        title: this.title,
      ),
      Divider()
    ],); 
  }
}