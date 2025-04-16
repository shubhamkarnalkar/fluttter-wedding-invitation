part of 'router_imports.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteConstants.home,
      builder: (context, state) => const Home(),
      routes: const [],
    ),
  ],
);
