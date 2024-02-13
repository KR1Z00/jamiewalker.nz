import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/custom_text_styles.dart';

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
          fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.w300,
          shadows: [
            StandardBoxShadows.light(),
          ],
        ),
      ),
    );
  }

  static ButtonStyle primaryActionButton(BuildContext context) {
    final layoutForMobile = context.layoutForMobile();
    final textStyle =
        layoutForMobile ? CustomTextStyles.header4 : CustomTextStyles.header3;
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
        textStyle(
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
