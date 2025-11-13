import 'package:flutter/material.dart';

///A utility class to keep styles in one place to DRY and make the code UI code
///easier to understand, and maintain
class AppWidget {
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle lightTextFieldStyle() {
    return TextStyle(
      color: Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle smallBoldTextFieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
