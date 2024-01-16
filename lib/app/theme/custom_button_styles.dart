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
          if (states.contains(MaterialState.hovered)) {
            return CustomColors.primaryColor;
          }
          return Colors.black;
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
}
