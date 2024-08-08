import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._internal();
  static final _instance = AppStyle._internal();
  factory AppStyle() {
    return _instance;
  }

  // App Color
  static const MaterialColor appColor = MaterialColor(
    0xff3b82f6, // Màu xanh da trời chính
    <int, Color>{
      50: Color(0xffd9e8ff),
      100: Color(0xffb3d1ff),
      200: Color(0xff8cbaff),
      300: Color(0xff66a3ff),
      400: Color(0xff408bff),
      500: Color(0xff3b82f6),
      600: Color(0xff3367d6),
      700: Color(0xff2a4cb6),
      800: Color(0xff223396),
      900: Color(0xff1b1f76),
    },
  );

  // Padding
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding16 = 16.0;
  static const double padding32 = 32.0;

  // Font size
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;

  // Icon size
  static const double iconSize18 = 18.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;
}
