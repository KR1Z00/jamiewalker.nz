import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/mobile_size.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  final JamieWalkerRoute currentRoute;
  final void Function() onHamburgerPressed;

  const JamieWalkerAppBar({
    super.key,
    required this.currentRoute,
    required this.onHamburgerPressed,
  });

  @override
  Widget build(BuildContext context) {
    final layoutForMobile = context.layoutForMobile();
    return ColoredBox(
      color: CustomColors.primaryColor.d2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    layoutForMobile ? _mobileRowItems() : _desktopRowItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The list of items to be added in the main row when laying out for desktop
  List<Widget> _desktopRowItems() {
    return List<Widget>.from(
          [
            Text(
              "Jamie Walker",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: CustomColors.secondaryColor.l1,
              ),
            ),
            const Spacer(),
          ],
        ) +
        List<Widget>.from(
          JamieWalkerRoute.values.map(
            (route) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: NavigationButton(
                  route: route,
                  isCurrentPage: route == currentRoute,
                  layoutAxis: Axis.horizontal,
                ),
              );
            },
          ),
        );
  }

  /// The list of items to be added in the main row when laying out for mobile
  List<Widget> _mobileRowItems() {
    return [
      Text(
        "Jamie Walker",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CustomColors.secondaryColor.l1,
        ),
      ),
      const Spacer(),
      IconButton(
        constraints: BoxConstraints.tight(const Size.square(50)),
        onPressed: () => onHamburgerPressed(),
        icon: Image.asset(
          'assets/icon_hamburger.png',
          color: CustomColors.secondaryColor.l1,
        ),
      ),
    ];
  }
}
