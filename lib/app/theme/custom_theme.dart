import 'package:flutter/material.dart';
import 'custom_colors.dart';

final ThemeData customThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.primaryColor, brightness: Brightness.dark),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(
      Colors.white.withOpacity(0.7),
    ),
  ),
  useMaterial3: true,
);
