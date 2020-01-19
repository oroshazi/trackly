import 'package:flutter/material.dart';
import 'package:trackly_app/helpers/build_bottom_sheet.dart';

class SelectCategoryWidget extends StatelessWidget {
  final String selectedCagetory;

  SelectCategoryWidget({@required this.selectedCagetory});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(
          selectedCagetory == null ? "Select an activity" : selectedCagetory),
      onTap: () => buildBottomSheet(context),
    );
  }
}
