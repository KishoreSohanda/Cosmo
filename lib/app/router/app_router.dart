import 'package:cosmo/app/router/route_names.dart';
import 'package:cosmo/features/home/presentation/apod_details_page.dart';
import 'package:cosmo/features/home/presentation/asteroid_details_page.dart';
import 'package:cosmo/features/home/presentation/launch_details_page.dart';
import 'package:cosmo/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shell/app_shell.dart';
import '../../features/home/presentation/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          // Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          // Explore
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.explore,
                name: RouteNames.explore,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Explore'),
              ),
            ],
          ),

          // Asteroids
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.asteroids,
                name: RouteNames.asteroids,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Asteroids'),
              ),
            ],
          ),

          // Launches
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.launches,
                name: RouteNames.launches,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Launches'),
              ),
            ],
          ),

          // Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.settings,
                name: RouteNames.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      // Detail / secondary pages
      GoRoute(
        path: RoutePaths.apodDetails,
        name: RouteNames.apodDetails,
        builder: (context, state) => const ApodDetailsPage(),
      ),

      GoRoute(
        path: RoutePaths.launchDetails,
        name: RouteNames.launchDetails,
        builder: (context, state) => const LaunchDetailsPage(),
      ),

      GoRoute(
        path: RoutePaths.asteroidDetails,
        name: RouteNames.asteroidDetails,
        builder: (context, state) => const AsteroidDetailsPage(),
      ),
    ],
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
