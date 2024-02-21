import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';
import 'custom_colors.dart';

ThemeData customThemeData(BuildContext context) => ThemeData(
      colorScheme: customColorScheme(context),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(
          Colors.white.withOpacity(0.7),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: CustomColors.secondaryColor.l1,
        space: 1,
        thickness: 1,
      ),
      textTheme: customTextTheme(context),
      useMaterial3: true,
    );

ColorScheme customColorScheme(BuildContext context) => ColorScheme.dark(
      primary: CustomColors.lightGrey.l2,
      onPrimary: CustomColors.darkGrey.d2,
      background: CustomColors.primaryColor.d2,
      onBackground: CustomColors.lightGrey.l2,
      error: Colors.red,
      onError: CustomColors.lightGrey.l2,
      errorContainer: Colors.red.l2,
      onErrorContainer: Colors.red.d1,
      secondary: CustomColors.secondaryColor.l1,
      onSecondary: CustomColors.darkGrey.d2,
      outline: CustomColors.secondaryColor.l1,
      outlineVariant: CustomColors.lightGrey.l2,
      surface: CustomColors.primaryColor.d1,
      onSurface: CustomColors.secondaryColor.l1,
      surfaceTint: CustomColors.lightGrey.l2,
      tertiary: CustomColors.primaryColor.l1,
      onTertiary: CustomColors.darkGrey.d2,
      primaryContainer: CustomColors.primaryColor.l2,
      onPrimaryContainer: CustomColors.darkGrey.d2,
      scrim: CustomColors.darkGrey.d2,
    );

extension ThemeDataExtensions on BuildContext {
  ThemeData theme() {
    return Theme.of(this);
  }

  ColorScheme colorScheme() {
    return theme().colorScheme;
  }
}
