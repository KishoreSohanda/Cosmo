import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';

class ApodDetailsPage extends StatelessWidget {
  const ApodDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.textPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'apod-featured-image',
                child: Image.network(
                  'https://assets.science.nasa.gov/dynamicimage/assets/science/cds/apod/apod/2026/october/sharpless_catalog.png?w=4455&h=5592&fit=clip&crop=faces%2Cfocalpoint',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.surface,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TweenAnimationBuilder<double>(
              duration: AppAnimations.normal,
              curve: AppAnimations.standard,
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing24,
                  AppTheme.spacing20,
                  AppTheme.spacing32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Complete Sharpless Catalog',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      'October 2, 2026',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    AppTheme.spacing24.verticalSpace,
                    Text(
                      'The Sharpless catalog contains 313 regions of ionized '
                      'interstellar gas in our galaxy. These emission nebulae '
                      'are illuminated by nearby hot stars and provide a '
                      'beautiful view of the structure of the Milky Way.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
