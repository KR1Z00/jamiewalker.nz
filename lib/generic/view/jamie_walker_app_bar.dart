import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/extensions/theme_extensions.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(70);

  final JamieWalkerRoute currentRoute;
  final void Function() onHamburgerPressed;

  const JamieWalkerAppBar({
    super.key,
    required this.currentRoute,
    required this.onHamburgerPressed,
  });

  @override
  Widget build(BuildContext context) {
    final layoutForMobile = context.layoutAppBarForMobile();
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 100,
          sigmaY: 100,
        ),
        child: ColoredBox(
          color: context.themeData().colorScheme.background.withOpacity(0.7),
          child: context.wrappedForHorizontalPosition(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: layoutForMobile
                  ? _mobileRowItems(context)
                  : _desktopRowItems(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _initialsIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        'assets/images/initials_icon.png',
        color: context.themeData().primaryColor,
      ),
    );
  }

  /// The list of items to be added in the main row when laying out for desktop
  List<Widget> _desktopRowItems(BuildContext context) {
    return List<Widget>.from(
          [
            _initialsIcon(context),
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
  List<Widget> _mobileRowItems(BuildContext context) {
    return [
      _initialsIcon(context),
      const Spacer(),
      IconButton(
        constraints: BoxConstraints.tight(const Size.square(50)),
        onPressed: () => onHamburgerPressed(),
        icon: Image.asset(
          'assets/images/icon_hamburger.png',
          color: CustomColors.secondaryColor.l1,
        ),
      ),
    ];
  }
}
