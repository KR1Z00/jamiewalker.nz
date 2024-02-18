import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'custom_colors.dart';

ThemeData customThemeData(BuildContext context) => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CustomColors.primaryColor,
        brightness: Brightness.dark,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(
          Colors.white.withOpacity(0.7),
        ),
      ),
      textTheme: customTextTheme(context),
      useMaterial3: true,
    );
