import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/extensions/screen_size.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(70);

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
    return context.wrappedForHorizontalPosition(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: layoutForMobile ? _mobileRowItems() : _desktopRowItems(),
      ),
    );
  }

  Widget _initialsIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Image.asset(
        'assets/images/initials_icon.png',
        color: CustomColors.secondaryColor.l1,
      ),
    );
  }

  /// The list of items to be added in the main row when laying out for desktop
  List<Widget> _desktopRowItems() {
    return List<Widget>.from(
          [
            _initialsIcon(),
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
  List<Widget> _mobileRowItems() {
    return [
      _initialsIcon(),
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
