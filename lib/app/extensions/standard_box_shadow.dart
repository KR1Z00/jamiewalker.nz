import 'package:flutter/material.dart';

extension StandardBoxShadows on BoxShadow {
  static BoxShadow regular() => BoxShadow(
        blurRadius: 10,
        offset: const Offset(0, 7),
        color: Colors.black12.withOpacity(0.6),
      );

  static BoxShadow light() => BoxShadow(
        blurRadius: 5,
        offset: const Offset(0, 3),
        color: Colors.black12.withOpacity(0.6),
      );
}
