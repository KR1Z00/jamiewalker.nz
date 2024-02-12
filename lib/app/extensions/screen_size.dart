import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  static const mobileWidth = 950;
  static const minimumPadding = 40;
  static const maximumContentSize = 1300;

  bool layoutForMobile() {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width < mobileWidth;
  }

  bool usePaddingForContentHorizontalPosition() {
    if (layoutForMobile()) {
      return true;
    }

    final screenSize = MediaQuery.of(this).size;
    return screenSize.width < (maximumContentSize + 2 * minimumPadding);
  }

  bool useCenterForContentHorizontalPosition() {
    return !usePaddingForContentHorizontalPosition();
  }

  Widget wrappedForHorizontalPosition({
    required Widget child,
  }) {
    if (useCenterForContentHorizontalPosition()) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: maximumContentSize.toDouble(),
            child: child,
          ),
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: minimumPadding.toDouble(),
        ),
        child: child,
      );
    }
  }
}
