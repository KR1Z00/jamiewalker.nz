import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jamie_walker_website/landing/view/landing_page.dart';

enum JamieWalkerRoute {
  home('/'),
  ;

  final String routePath;

  const JamieWalkerRoute(
    this.routePath,
  );
}

final jamieWalkerRouterConfig = GoRouter(
  initialLocation: JamieWalkerRoute.home.routePath,
  routes: [
    GoRoute(
      path: JamieWalkerRoute.home.routePath,
      builder: (context, state) {
        return LandingPage();
      },
    ),
  ],
);

extension RouterNavigation on BuildContext {
  void goJWRoute(JamieWalkerRoute route) {
    go(route.routePath);
  }

  void pushJWRoute(JamieWalkerRoute route) {
    push(route.routePath);
  }
}
