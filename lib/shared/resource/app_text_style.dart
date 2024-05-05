import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle latoStyle(
      {required double size,
      FontWeight fontWeight = FontWeight.w700,
      Color color = Colors.black}) {
    return TextStyle(
        fontFamily: "Poppins",
        fontSize: size.sp,
        fontWeight: FontWeight.w700,
        color: color);
  }
}
