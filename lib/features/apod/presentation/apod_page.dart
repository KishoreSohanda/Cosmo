import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';

class ApodPage extends StatelessWidget {
  const ApodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final items = [
      (
        title: 'The Complete Sharpless Catalog: 313 Nebulas',
        date: 'October 2, 2026',
        imageUrl:
            'https://assets.science.nasa.gov/dynamicimage/assets/science/cds/apod/apod/2026/october/sharpless_catalog.png?w=1200',
      ),
      (
        title: 'Harvest Moon with Erupting Mount Etna',
        date: 'October 1, 2026',
        imageUrl: 'https://apod.nasa.gov/apod/image/2610/EtnaMoon_1024.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.astronomyPictureOfTheDay)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing8,
                  AppTheme.spacing20,
                  AppTheme.spacing24,
                ),
                child: Text(
                  l10n.exploreApodDescription,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing20,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = items[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == items.length - 1
                          ? 0
                          : AppTheme.spacing20,
                    ),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: AppAnimations.normal,
                      curve: AppAnimations.standard,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 16 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: _ApodCard(
                        title: item.title,
                        date: item.date,
                        imageUrl: item.imageUrl,
                        onTap: () {
                          // Details navigation will be connected
                          // to the selected APOD item later.
                        },
                      ),
                    ),
                  );
                }, childCount: items.length),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppTheme.spacing24),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApodCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final VoidCallback onTap;

  const _ApodCard({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppTheme.radius20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 210,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 210,
                  color: theme.colorScheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined, size: 40),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: theme.textTheme.labelMedium),
                  AppTheme.spacing8.verticalSpace,
                  Text(title, style: theme.textTheme.titleMedium),
                  AppTheme.spacing8.verticalSpace,
                  Row(
                    children: [
                      Text(
                        'View details',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      AppTheme.spacing4.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
