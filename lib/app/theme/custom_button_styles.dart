import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
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
            return CustomColors.secondaryColor.l1;
          }
          return Colors.white;
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

  static ButtonStyle primaryActionButton(BuildContext context) {
    final layoutForMobile = context.layoutForMobile();
    final textTheme = context.textTheme();

    final textStyle =
        layoutForMobile ? textTheme.labelMedium : textTheme.labelLarge;
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        CustomColors.secondaryColor.l1,
      ),
      foregroundColor: MaterialStateProperty.all(
        CustomColors.primaryColor.d2,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
      ),
      overlayColor: MaterialStateProperty.all(
        Colors.white.withOpacity(0.5),
      ),
      textStyle: MaterialStateProperty.all(
        textStyle?.copyWith(
          color: CustomColors.primaryColor.d2,
        ),
      ),
    );
  }

  static ButtonStyle secondaryIconButton() {
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
        CustomColors.secondaryColor.l1.withOpacity(0.5),
      ),
    );
  }
}
