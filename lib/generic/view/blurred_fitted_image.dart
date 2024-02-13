import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredFittedImage extends StatelessWidget {
  final String asset;

  const BlurredFittedImage({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(asset),
              ),
            ),
          ),
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(asset),
            ),
          ),
        ],
      ),
    );
  }
}
