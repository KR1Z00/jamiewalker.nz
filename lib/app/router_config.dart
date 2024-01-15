import 'package:go_router/go_router.dart';
import 'package:jamie_walker_website/home/view/home_page.dart';

enum Route {
  home('/'),
  ;

  final String routePath;
  const Route(this.routePath);
}

final routerConfig = GoRouter(
  initialLocation: Route.home.routePath,
  routes: [
    GoRoute(
      path: Route.home.routePath,
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
