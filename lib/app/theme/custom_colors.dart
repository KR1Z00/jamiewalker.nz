import 'package:flutter/material.dart';

extension CustomColors on MaterialColor {
  static const MaterialColor primaryColor = MaterialColor(
    0xFF3572AC,
    {
      50: Color(0xFFEFF5FF),
      100: Color(0xFFEFF5FF),
      200: Color(0xFFDBDDE0),
      300: Color(0xFF88A8C6),
      400: Color(0xFF88A8C6),
      500: Color(0xFF3572AC),
      600: Color(0xFF244E75),
      700: Color(0xFF244E75),
      800: Color(0xFF13293D),
      900: Color(0xFF13293D),
    },
  );

  static const MaterialColor secondaryColor = MaterialColor(
    0xFFFFD147,
    {
      50: Color(0xFFFFF5D6),
      100: Color(0xFFFFF5D6),
      200: Color(0xFFFFF5D6),
      300: Color(0xFFFFE38F),
      400: Color(0xFFFFE38F),
      500: Color(0xFFFFD147),
      600: Color(0xFFF5B800),
      700: Color(0xFFF5B800),
      800: Color(0xFF291F00),
      900: Color(0xFF291F00),
    },
  );

  static const MaterialColor lightGrey = MaterialColor(
    0xFFCECECE,
    {
      50: Color(0xFFF3F3F3),
      100: Color(0xFFF3F3F3),
      200: Color(0xFFF3F3F3),
      300: Color(0xFFDFDFDF),
      400: Color(0xFFDFDFDF),
      500: Color(0xFFCECECE),
      600: Color(0xFFB7B7B7),
      700: Color(0xFFB7B7B7),
      800: Color(0xFFA3A3A3),
      900: Color(0xFFA3A3A3),
    },
  );

  static const MaterialColor darkGrey = MaterialColor(
    0xFF646464,
    {
      50: Color(0xFF767676),
      100: Color(0xFF767676),
      200: Color(0xFF767676),
      300: Color(0xFF646464),
      400: Color(0xFF646464),
      500: Color(0xFF434343),
      600: Color(0xFF2D2D2D),
      700: Color(0xFF2D2D2D),
      800: Color(0xFF111111),
      900: Color(0xFF111111),
    },
  );

  Color get l2 => shade100;
  Color get l1 => shade300;
  Color get m => shade500;
  Color get d1 => shade600;
  Color get d2 => shade800;
}
