import 'package:cosmo/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../l10n/app_localizations.dart';

class NasaImagesPage extends StatelessWidget {
  const NasaImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final items = [
      (
        title: 'The Pillars of Creation',
        imageUrl:
            'https://images-assets.nasa.gov/image/PIA20063/PIA20063~orig.jpg',
      ),
      (
        title: 'The Andromeda Galaxy',
        imageUrl:
            'https://images-assets.nasa.gov/image/PIA04921/PIA04921~orig.jpg',
      ),
      (
        title: 'The Eagle Nebula',
        imageUrl:
            'https://images-assets.nasa.gov/image/PIA07747/PIA07747~orig.jpg',
      ),
      (
        title: 'Galaxies Beyond',
        imageUrl:
            'https://images-assets.nasa.gov/image/PIA16884/PIA16884~orig.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nasaImages)),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing8,
                  AppTheme.spacing20,
                  AppTheme.spacing20,
                ),
                child: Text(
                  l10n.nasaImagesDescription,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing20,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppTheme.spacing12,
                  mainAxisSpacing: AppTheme.spacing16,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = items[index];

                  return TweenAnimationBuilder<double>(
                    key: ValueKey(item.title),
                    tween: Tween(begin: 0, end: 1),
                    duration: AppAnimations.normal,
                    curve: AppAnimations.standard,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: _NasaImageCard(
                      title: item.title,
                      imageUrl: item.imageUrl,
                      onTap: () {
                        context.pushNamed(RouteNames.nasaImageDetails);
                      },
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

class _NasaImageCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _NasaImageCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppTheme.radius14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: double.infinity,
                    child: ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image_outlined, size: 36),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
