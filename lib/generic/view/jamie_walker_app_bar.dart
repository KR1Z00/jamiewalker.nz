import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/extensions/standard_box_shadow.dart';
import 'package:jamie_walker_website/app/theme/custom_theme.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double preferredHeight = 70;

  @override
  Size get preferredSize => const Size.fromHeight(preferredHeight);

  final void Function() onHamburgerPressed;
  final List<String> navigationItemTitles;
  final int currentNavigationItemIndex;
  final void Function(int index) onNavigationItemIndexPressed;

  const JamieWalkerAppBar({
    super.key,
    required this.onHamburgerPressed,
    required this.navigationItemTitles,
    required this.currentNavigationItemIndex,
    required this.onNavigationItemIndexPressed,
  });

  @override
  Widget build(BuildContext context) {
    final layoutForMobile = context.layoutForMobile();
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          StandardBoxShadows.regular(),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ColoredBox(
            color: context.colorScheme().background.withOpacity(0.5),
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
      ),
    );
  }

  Widget _initialsIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Image.asset(
        'assets/images/initials_icon.png',
        color: context.colorScheme().secondary,
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
          navigationItemTitles.mapIndexed(
            (index, title) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: NavigationButton(
                  title: title,
                  isCurrentItem: index == currentNavigationItemIndex,
                  layoutAxis: Axis.horizontal,
                  onPressed: () => onNavigationItemIndexPressed(
                    index,
                  ),
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
          'assets/images/hamburger.png',
        ),
      ),
    ];
  }
}
