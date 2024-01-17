import 'package:flutter/material.dart';

extension MobileSize on BuildContext {
  static const mobileWidth = 700;

  bool layoutForMobile() {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width < mobileWidth;
  }
}
