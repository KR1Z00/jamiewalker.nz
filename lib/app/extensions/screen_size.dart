import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  static const mobileWidth = 950;
  static const minimumPadding = 40;
  static const maximumContentSize = 1300;

  bool layoutForMobile() {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width < mobileWidth;
  }
}
