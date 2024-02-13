import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/theme/custom_colors.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerNavigationDrawer extends StatelessWidget {
  final List<String> navigationItemTitles;
  final int currentNavigationItemIndex;
  final void Function(int index) onNavigationItemIndexPressed;

  const JamieWalkerNavigationDrawer({
    super.key,
    required this.navigationItemTitles,
    required this.currentNavigationItemIndex,
    required this.onNavigationItemIndexPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.primaryColor.d2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.from(
            navigationItemTitles.mapIndexed(
              (index, title) => NavigationButton(
                title: title,
                isCurrentItem: index == currentNavigationItemIndex,
                layoutAxis: Axis.vertical,
                onPressed: () => onNavigationItemIndexPressed(
                  index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
