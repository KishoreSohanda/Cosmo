import 'package:cosmo/app/router/route_names.dart';
import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:cosmo/features/home/presentation/widgets/apod_featured_card.dart';
import 'package:cosmo/features/home/presentation/widgets/asteroid_card.dart';
import 'package:cosmo/features/home/presentation/widgets/explore_more_card.dart';
import 'package:cosmo/features/home/presentation/widgets/launch_card.dart';
import 'package:cosmo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/home_header.dart';
import 'widgets/section_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            const HomeHeader(),

            28.verticalSpace,

            SectionHeader(title: l10n.astronomyPictureOfTheDay),

            24.verticalSpace,

            const ApodFeaturedCard(),

            28.verticalSpace,

            SectionHeader(
              title: l10n.upcomingLaunches,
              onViewAll: () {
                context.goNamed(RouteNames.launches);
              },
            ),

            24.verticalSpace,

            LaunchCard(
              missionName: 'Starlink Group 10-25',
              provider: 'SpaceX',
              date: 'October 8, 2026',
              status: 'Upcoming',
              onTap: () {
                context.pushNamed(RouteNames.launchDetails);
              },
            ),

            28.verticalSpace,

            SectionHeader(
              title: l10n.closeApproaches,
              onViewAll: () {
                context.goNamed(RouteNames.asteroids);
              },
            ),

            24.verticalSpace,

            AsteroidCard(
              name: '2026 AB1',
              date: 'October 9, 2026',
              distance: '4.2 million km',
              velocity: '18.6',
              onTap: () {
                context.pushNamed(RouteNames.asteroidDetails);
              },
            ),

            28.verticalSpace,

            SectionHeader(title: l10n.exploreMore),

            24.verticalSpace,

            Row(
              children: [
                Expanded(
                  child: ExploreMoreCard(
                    icon: Icons.image_outlined,
                    title: l10n.nasaImages,
                    description: l10n.nasaImagesDescription,
                    onTap: () {
                      context.pushNamed(RouteNames.nasaImages);
                    },
                  ),
                ),

                12.horizontalSpace,

                Expanded(
                  child: ExploreMoreCard(
                    icon: Icons.public_outlined,
                    title: l10n.exoplanets,
                    description: l10n.exoplanetsDescription,
                    onTap: () {
                      context.pushNamed(RouteNames.exoplanets);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
