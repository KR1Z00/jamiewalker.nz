import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

typedef CustomTextStyle = TextStyle Function({
  Color? color,
  FontStyle? fontStyle,
});

extension CustomTextStyles on TextStyle {
  static CustomTextStyle header1 = ({color, fontStyle}) => TextStyle(
        fontSize: 64,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
        fontStyle: fontStyle,
      );

  static CustomTextStyle header2 = ({color, fontStyle}) => TextStyle(
        fontSize: 48,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
        fontStyle: fontStyle,
      );

  static CustomTextStyle header3 = ({color, fontStyle}) => TextStyle(
        fontSize: 24,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
        fontStyle: fontStyle,
      );

  static CustomTextStyle header4 = ({color, fontStyle}) => TextStyle(
        fontSize: 18,
        color: color ?? CustomColors.secondaryColor.l1,
        fontWeight: FontWeight.bold,
        fontStyle: fontStyle,
      );

  static CustomTextStyle paragraph1 = ({color, fontStyle}) => TextStyle(
        fontSize: 24,
        color: color ?? Colors.white,
        fontStyle: fontStyle,
      );

  static CustomTextStyle paragraph2 = ({color, fontStyle}) => TextStyle(
        fontSize: 18,
        color: color ?? Colors.white,
        fontStyle: fontStyle,
      );

  static CustomTextStyle paragraph3 = ({color, fontStyle}) => TextStyle(
        fontSize: 14,
        color: color ?? Colors.white,
        fontStyle: fontStyle,
      );
}
