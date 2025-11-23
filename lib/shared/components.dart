import 'package:flutter/material.dart';

///this file will include  reusable components (widgets)
Widget CircledBackButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      margin: EdgeInsets.only(left: 10, top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(), shape: BoxShape.circle, color: Colors.white),
      child: Icon(Icons.arrow_back_ios_new_outlined),
    ),
  );
}
