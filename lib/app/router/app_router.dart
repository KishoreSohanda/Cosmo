import 'package:cosmo/app/router/route_names.dart';
import 'package:cosmo/features/apod/bloc/apod_bloc.dart';
import 'package:cosmo/features/apod/bloc/apod_event.dart';
import 'package:cosmo/features/apod/data/repositories/apod_repository.dart';
import 'package:cosmo/features/apod/presentation/apod_page.dart';
import 'package:cosmo/features/asteroids/presentation/asteroids_page.dart';
import 'package:cosmo/features/exoplanets/presentation/exoplanet_details_page.dart';
import 'package:cosmo/features/exoplanets/presentation/exoplanets_page.dart';
import 'package:cosmo/features/explore/presentation/explore_page.dart';
import 'package:cosmo/features/apod/presentation/apod_details_page.dart';
import 'package:cosmo/features/asteroids/presentation/asteroid_details_page.dart';
import 'package:cosmo/features/launches/presentation/launch_details_page.dart';
import 'package:cosmo/features/launches/presentation/launches_page.dart';
import 'package:cosmo/features/nasa_images/presentation/nasa_image_details_page.dart';
import 'package:cosmo/features/nasa_images/presentation/nasa_images_page.dart';
import 'package:cosmo/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),

          // Asteroids
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.asteroids,
                name: RouteNames.asteroids,
                builder: (context, state) => const AsteroidsPage(),
              ),
            ],
          ),

          // Launches
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.launches,
                name: RouteNames.launches,
                builder: (context, state) => const LaunchesPage(),
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
      GoRoute(
        path: RoutePaths.exoplanets,
        name: RouteNames.exoplanets,
        builder: (context, state) => const ExoplanetsPage(),
      ),
      GoRoute(
        path: RoutePaths.nasaImages,
        name: RouteNames.nasaImages,
        builder: (context, state) => const NasaImagesPage(),
      ),

      GoRoute(
        path: RoutePaths.apod,
        name: RouteNames.apod,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                ApodBloc(repository: ApodRepository())
                  ..add(const ApodListRequested()),
            child: const ApodPage(),
          );
        },
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

      GoRoute(
        path: RoutePaths.nasaImageDetails,
        name: RouteNames.nasaImageDetails,
        builder: (context, state) => const NasaImageDetailsPage(),
      ),
      GoRoute(
        path: RoutePaths.exoplanetDetails,
        name: RouteNames.exoplanetDetails,
        builder: (context, state) => const ExoplanetDetailsPage(),
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
