import 'package:flutter/material.dart';

extension StandardBoxShadows on BoxShadow {
  static BoxShadow regular() => BoxShadow(
        blurRadius: 10,
        color: Colors.black12.withOpacity(0.6),
        blurStyle: BlurStyle.outer,
      );

  static BoxShadow light() => BoxShadow(
        blurRadius: 5,
        color: Colors.black12.withOpacity(0.6),
        blurStyle: BlurStyle.outer,
      );
}
