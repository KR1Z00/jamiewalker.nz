import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';
import 'package:jamie_walker_website/generic/view/navigation_button.dart';

class JamieWalkerNavigationDrawer extends StatelessWidget {
  final JamieWalkerRoute currentRoute;

  const JamieWalkerNavigationDrawer({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List<Widget>.from(
            JamieWalkerRoute.values.map(
              (route) => NavigationButton(
                route: route,
                isCurrentPage: route == currentRoute,
                layoutAxis: Axis.vertical,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
