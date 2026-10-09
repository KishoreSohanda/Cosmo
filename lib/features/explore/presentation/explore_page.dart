import 'package:cosmo/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';
import 'widgets/explore_feature_card.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.explore, style: theme.textTheme.headlineMedium),
              AppTheme.spacing8.verticalSpace,
              Text(l10n.discoverTheUniverse, style: theme.textTheme.bodyMedium),
              AppTheme.spacing24.verticalSpace,
              ExploreFeatureCard(
                title: l10n.astronomyPictureOfTheDay,
                subtitle: l10n.exploreApodDescription,
                icon: Icons.auto_awesome,
                onTap: () {
                  context.pushNamed(RouteNames.apod);
                },
                animationDelay: 0,
              ),
              AppTheme.spacing16.verticalSpace,
              ExploreFeatureCard(
                title: l10n.nasaImages,
                subtitle: l10n.nasaImagesDescription,
                icon: Icons.public,
                onTap: () {
                  context.pushNamed(RouteNames.nasaImages);
                },
                animationDelay: 100,
              ),
              AppTheme.spacing16.verticalSpace,
              ExploreFeatureCard(
                title: l10n.exoplanets,
                subtitle: l10n.exoplanetsDescription,
                icon: Icons.blur_circular,
                onTap: () {
                  context.pushNamed(RouteNames.exoplanets);
                },
                animationDelay: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
