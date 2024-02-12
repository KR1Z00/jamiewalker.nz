import 'package:flutter/material.dart';
import 'custom_colors.dart';

final ThemeData customThemeData = ThemeData(
  textTheme: customTextTheme,
  fontFamily: "helvetica",
  primarySwatch: CustomColors.primaryColor,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    error: Colors.red,
    onError: CustomColors.white,
    onBackground: CustomColors.black,
    primary: CustomColors.primaryColor.m,
    onPrimary: CustomColors.white,
    secondary: CustomColors.black,
    onSecondary: CustomColors.white,
    background: CustomColors.white,
    surface: CustomColors.primaryColor.l2,
    onSurface: CustomColors.black,
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(
      Colors.black.withOpacity(0.7),
    ),
  ),
  useMaterial3: true,
);

final TextTheme customTextTheme = TextTheme(
  displayLarge: TextStyle(),
  displayMedium: TextStyle(),
  displaySmall: TextStyle(),
  headlineLarge: TextStyle(),
  headlineMedium: TextStyle(),
  headlineSmall: TextStyle(),
  titleLarge: TextStyle(),
  titleMedium: TextStyle(),
  titleSmall: TextStyle(),
  bodyLarge: TextStyle(),
  bodyMedium: TextStyle(),
  bodySmall: TextStyle(),
  labelLarge: TextStyle(),
  labelMedium: TextStyle(),
  labelSmall: TextStyle(),
);
