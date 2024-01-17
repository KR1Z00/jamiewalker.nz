import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jamie_walker_website/home/view/home_page.dart';

enum JamieWalkerRoute {
  home('/', 'Home'),
  services('/services', 'Services'),
  testimonials('/testimonials', 'Testimonials'),
  portfolio('/portfolio', 'Portfolio'),
  blog('/blog', 'Blog'),
  contact('/contact', 'Contact'),
  ;

  final String routePath;
  final String title;

  const JamieWalkerRoute(
    this.routePath,
    this.title,
  );
}

final jamieWalkerRouterConfig = GoRouter(
  initialLocation: JamieWalkerRoute.home.routePath,
  routes: [
    GoRoute(
      path: JamieWalkerRoute.home.routePath,
      builder: (context, state) {
        return HomePage();
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
