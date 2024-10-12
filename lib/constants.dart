import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const kPrimary = Color(0xff5a3a8c);

  static const MaterialColor kSwatchColor = MaterialColor(
    0xff5a3a8c, 
    <int, Color>{
      50: Color(0xff6b4c9b), //10% - lighter purple
      100: Color(0xff7b5eaa), //20%
      200: Color(0xff8b70b9), //30%
      300: Color(0xff9c82c8), //40%
      400: Color(0xffac94d7), //50%
      500: Color(0xffbcaae6), //60%
      600: Color(0xffccbce9), //70%
      700: Color(0xffdbcdf1), //80%
      800: Color(0xffebe0f6), //90%
      900: Color(0xfffaf3ff), //100% - very light pastel purple
    },
  );

  static int? juzIndex;
  static int? surahIndex;
}
