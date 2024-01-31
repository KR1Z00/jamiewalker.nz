import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

extension CustomButtonStyles on ButtonStyle {
  static ButtonStyle navigationButton({required bool isCurrentPage}) {
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
        TextStyle(
          fontSize: 20,
          fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  static ButtonStyle primaryActionButton() {
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
        const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
