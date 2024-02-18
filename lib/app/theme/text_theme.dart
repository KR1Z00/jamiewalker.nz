import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';

TextStyle _titleFontFamily = GoogleFonts.nunito();
TextStyle _bodyFontFamily = GoogleFonts.openSans();

TextTheme customTextTheme(BuildContext context) {
  final layoutForMobile = context.layoutForMobile();
  return TextTheme(
    displayLarge: _titleFontFamily.copyWith(
      fontSize: layoutForMobile ? 60 : 96,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: _titleFontFamily.copyWith(
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: _titleFontFamily.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: _titleFontFamily.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: _titleFontFamily.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: _titleFontFamily.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: _bodyFontFamily.copyWith(
      fontSize: 22,
    ),
    titleMedium: _bodyFontFamily.copyWith(
      fontSize: 16,
    ),
    titleSmall: _bodyFontFamily.copyWith(
      fontSize: 14,
    ),
    labelLarge: _bodyFontFamily.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: _bodyFontFamily.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: _bodyFontFamily.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: _bodyFontFamily.copyWith(
      fontSize: 16,
    ),
    bodyMedium: _bodyFontFamily.copyWith(
      fontSize: 14,
    ),
    bodySmall: _bodyFontFamily.copyWith(
      fontSize: 12,
    ),
  );
}
