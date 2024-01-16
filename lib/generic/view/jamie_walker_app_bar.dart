import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_button_styles.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';

class JamieWalkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  final JamieWalkerRoute currentRoute;

  const JamieWalkerAppBar({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List<Widget>.from(
                      [
                        const Text(
                          "Jamie Walker",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ) +
                    List<Widget>.from(
                      JamieWalkerRoute.values.map(
                        (route) {
                          return _NavigationButton(
                            route: route,
                            isCurrentPage: route == currentRoute,
                          );
                        },
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatefulWidget {
  static const double underlineSize = 2;

  final JamieWalkerRoute route;
  final bool isCurrentPage;

  const _NavigationButton({
    super.key,
    required this.route,
    required this.isCurrentPage,
  });

  @override
  State<_NavigationButton> createState() => __NavigationButtonState();
}

class __NavigationButtonState extends State<_NavigationButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double underlineSize =
        isHovered ? _NavigationButton.underlineSize : 0;

    return MouseRegion(
      onEnter: (event) => setState(() {
        isHovered = true;
      }),
      onExit: (event) => setState(() {
        isHovered = false;
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextButton(
                    onPressed: () => context.goJWRoute(widget.route),
                    style: CustomButtonStyles.navigationButton(
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
                  color: CustomColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
