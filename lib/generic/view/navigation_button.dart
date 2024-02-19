import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/app/theme/text_theme.dart';

class NavigationButton extends StatefulWidget {
  static const double underlineSize = 2;

  final String title;
  final bool isCurrentItem;
  final Axis layoutAxis;
  final void Function() onPressed;

  const NavigationButton({
    super.key,
    required this.title,
    required this.isCurrentItem,
    required this.layoutAxis,
    required this.onPressed,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  static const animationDuration = Duration(milliseconds: 150);
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double underlineSize = isHovered ? NavigationButton.underlineSize : 0;
    final textStyle = context.textTheme().titleLarge!.copyWith(
          color: isHovered || widget.isCurrentItem
              ? CustomColors.secondaryColor.l1
              : Colors.white,
        );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() {
        isHovered = true;
      }),
      onExit: (event) => setState(() {
        isHovered = false;
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _widthFixedForLayoutAxis(
            layoutAxis: widget.layoutAxis,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: widget.onPressed,
                    child: AnimatedDefaultTextStyle(
                      style: textStyle,
                      duration: animationDuration,
                      child: Text(
                        widget.title,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: animationDuration,
                  constraints: BoxConstraints.tightFor(height: underlineSize),
                  color: CustomColors.secondaryColor.l1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Wraps the [child], so that its width is fixed according to the [layoutAxis].
  ///
  /// If we are laying out across the horizontal axis, we want to make the buttons
  /// have their width meet the size of the TextButton.
  /// If we are laying out across the vertical axis, we don't.
  Widget _widthFixedForLayoutAxis({
    required Axis layoutAxis,
    required Widget child,
  }) {
    if (layoutAxis == Axis.vertical) {
      return child;
    } else {
      return IntrinsicWidth(
        child: child,
      );
    }
  }
}
