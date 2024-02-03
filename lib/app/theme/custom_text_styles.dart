import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

extension CustomTextStyles on TextStyle {
  static TextStyle header1({Color? color}) => TextStyle(
        fontSize: 64,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle header2({Color? color}) => TextStyle(
        fontSize: 48,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle header3({Color? color}) => TextStyle(
        fontSize: 24,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle header4({Color? color}) => TextStyle(
        fontSize: 18,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
      );

  static TextStyle paragraph1({Color? color}) => TextStyle(
        fontSize: 24,
        color: color ?? Colors.white,
      );

  static TextStyle paragraph2({Color? color}) => TextStyle(
        fontSize: 18,
        color: color ?? Colors.white,
      );

  static TextStyle paragraph3({Color? color}) => TextStyle(
        fontSize: 14,
        color: color ?? Colors.white,
      );
}
