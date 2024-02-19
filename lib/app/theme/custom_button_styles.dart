import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';

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
            return context.colorScheme().secondary;
          }
          return context.colorScheme().onBackground;
        },
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      textStyle: MaterialStateProperty.all(
        context.textTheme().titleLarge,
      ),
    );
  }

  static ButtonStyle secondaryIconButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: MaterialStateProperty.all(
        context.colorScheme().secondary.withOpacity(0.5),
      ),
    );
  }
}
