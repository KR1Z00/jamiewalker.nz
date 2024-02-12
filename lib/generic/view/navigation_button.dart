import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

class NavigationButton extends StatefulWidget {
  static const double underlineSize = 2;

  final JamieWalkerRoute route;
  final bool isCurrentPage;
  final Axis layoutAxis;

  const NavigationButton({
    super.key,
    required this.route,
    required this.isCurrentPage,
    required this.layoutAxis,
  });

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double underlineSize = isHovered ? NavigationButton.underlineSize : 0;

    return MouseRegion(
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
                  child: TextButton(
                    onPressed: () => context.goJWRoute(widget.route),
                    style: CustomButtonStyles.navigationButton(
                      context,
                      isCurrentPage: widget.isCurrentPage,
                    ),
                    child: Text(
                      widget.route.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  constraints: BoxConstraints.tightFor(height: underlineSize),
                  color: context.themeData().primaryColor,
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
