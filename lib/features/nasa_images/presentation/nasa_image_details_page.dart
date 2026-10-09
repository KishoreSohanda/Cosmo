import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';

class NasaImageDetailsPage extends StatelessWidget {
  const NasaImageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const title = 'The Pillars of Creation';
    const imageUrl =
        'https://images-assets.nasa.gov/image/PIA20063/PIA20063~orig.jpg';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            title: const Text('Image Details'),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.broken_image_outlined, size: 48),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: AppAnimations.slow,
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
                  child: Text(title, style: theme.textTheme.headlineMedium),
                ),
                AppTheme.spacing12.verticalSpace,
                Text(
                  'NASA Image Library',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTheme.spacing24.verticalSpace,
                Text('About this image', style: theme.textTheme.titleLarge),
                AppTheme.spacing8.verticalSpace,
                Text(
                  'Explore the beauty of the universe through this '
                  'astronomical image. Discover the structures, stars, '
                  'and cosmic dust that make space fascinating.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppTheme.spacing24.verticalSpace,
                Text('Image information', style: theme.textTheme.titleLarge),
                AppTheme.spacing16.verticalSpace,
                _InfoRow(label: 'Source', value: 'NASA'),
                AppTheme.spacing12.verticalSpace,
                _InfoRow(
                  label: 'Collection',
                  value: 'NASA Image and Video Library',
                ),
                AppTheme.spacing24.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        AppTheme.spacing12.horizontalSpace,
        Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
      ],
    );
  }
}
