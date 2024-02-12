import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

extension CustomButtonStyles on ButtonStyle {
  static ButtonStyle navigationButton(
    BuildContext context, {
    required bool isCurrentPage,
  }) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (isCurrentPage || states.contains(MaterialState.hovered)) {
            return CustomColors.primaryColor;
          }
          return CustomColors.black;
        },
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 20,
          fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w300,
        ),
      ),
    );
  }

  static ButtonStyle primaryActionButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        context.themeData().colorScheme.primary,
      ),
      foregroundColor: MaterialStateProperty.all(
        context.themeData().colorScheme.onPrimary,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.white.withOpacity(0.2),
      ),
      textStyle: MaterialStateProperty.all(
        context.themeData().textTheme.displaySmall,
      ),
    );
  }

  static ButtonStyle secondaryIconButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: MaterialStateProperty.all(
        context.themeData().colorScheme.primary,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: MaterialStateProperty.all(
        context.themeData().colorScheme.primary.withOpacity(0.3),
      ),
    );
  }
}
