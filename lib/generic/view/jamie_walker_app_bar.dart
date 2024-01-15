import 'package:flutter/material.dart';
import 'package:jamie_walker_website/app/jamie_walker_router_config.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: JamieWalkerRoute.values.map(
                (route) {
                  final isCurrentRoute = route == currentRoute;
                  return _buildNavigationButton(
                    context,
                    route: route,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context, {
    required JamieWalkerRoute route,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextButton(
        onPressed: () => context.goJWRoute(route),
        child: Text(
          route.title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
