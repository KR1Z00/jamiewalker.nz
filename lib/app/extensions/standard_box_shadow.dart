import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

extension StandardBoxShadows on BoxShadow {
  static BoxShadow regular() => BoxShadow(
        blurRadius: 10,
        offset: const Offset(0, 7),
        color: CustomColors.black.withOpacity(0.6),
      );

  static BoxShadow light() => BoxShadow(
        blurRadius: 5,
        offset: const Offset(0, 3),
        color: CustomColors.black.withOpacity(0.6),
      );
}
