import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shell/app_shell.dart';

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
                path: '/home',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Home'),
              ),
            ],
          ),

          // Explore
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Explore'),
              ),
            ],
          ),

          // Asteroids
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/asteroids',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Asteroids'),
              ),
            ],
          ),

          // Launches
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/launches',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Launches'),
              ),
            ],
          ),

          // Settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Settings'),
              ),
            ],
          ),
        ],
      ),

      // Detail pages will go here later.
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
