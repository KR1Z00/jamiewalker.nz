import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StandardHorizontalPadding extends StatelessWidget {
  final Widget child;

  const StandardHorizontalPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      desktop: (context) => _StandardHorizontalPaddingDesktop(
        child: child,
      ),
      mobile: (context) => _StandardHorizontalPaddingMobile(
        child: child,
      ),
    );
  }
}

class _StandardHorizontalPaddingDesktop extends StatelessWidget {
  static const double minimumHorizontalPadding = 40;
  static const double maximumWidth = 1300;

  final Widget child;

  const _StandardHorizontalPaddingDesktop({required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: minimumHorizontalPadding,
        ),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: maximumWidth,
            ),
            child: child,
          ),
        ),
        const SizedBox(
          width: minimumHorizontalPadding,
        ),
      ],
    );
  }
}

class _StandardHorizontalPaddingMobile extends StatelessWidget {
  static const double horizontalPadding = 20;

  final Widget child;

  const _StandardHorizontalPaddingMobile({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      child: child,
    );
  }
}
