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

  Color get l2 => shade100;
  Color get l1 => shade300;
  Color get m => shade500;
  Color get d1 => shade600;
  Color get d2 => shade800;
}
