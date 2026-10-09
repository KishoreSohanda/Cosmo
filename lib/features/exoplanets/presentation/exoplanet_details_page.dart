import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';

class ExoplanetDetailsPage extends StatelessWidget {
  const ExoplanetDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const name = 'Proxima Centauri b';
    const type = 'Terrestrial Exoplanet';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            title: const Text('Planet Details'),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.1, -0.1),
                    radius: 0.9,
                    colors: [
                      Color(0xFF3459A8),
                      Color(0xFF151B35),
                      Color(0xFF050816),
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.85, end: 1),
                    duration: AppAnimations.slow,
                    curve: AppAnimations.emphasized,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8DB9FF),
                            Color(0xFF3867B7),
                            Color(0xFF17294F),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF4F8EF7,
                            ).withValues(alpha: 0.35),
                            blurRadius: 45,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(name, style: theme.textTheme.headlineMedium),
                AppTheme.spacing8.verticalSpace,
                Text(
                  type,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTheme.spacing16.verticalSpace,
                Text(
                  'A world beyond our Solar System',
                  style: theme.textTheme.titleLarge,
                ),
                AppTheme.spacing8.verticalSpace,
                Text(
                  'Proxima Centauri b is an exoplanet orbiting Proxima '
                  'Centauri, the closest star to our Sun. It is an '
                  'important target in the search for planets that may '
                  'have conditions suitable for liquid water. Its actual '
                  'surface conditions are still uncertain.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppTheme.spacing24.verticalSpace,
                Text('Planet Overview', style: theme.textTheme.titleLarge),
                AppTheme.spacing16.verticalSpace,
                const _FactCard(
                  icon: Icons.star_outline,
                  label: 'Host Star',
                  value: 'Proxima Centauri',
                ),
                AppTheme.spacing12.verticalSpace,
                const _FactCard(
                  icon: Icons.place_outlined,
                  label: 'Distance from Earth',
                  value: 'About 4.24 light-years',
                ),
                AppTheme.spacing12.verticalSpace,
                const _FactCard(
                  icon: Icons.public,
                  label: 'Planet Type',
                  value: 'Likely rocky',
                ),
                AppTheme.spacing12.verticalSpace,
                const _FactCard(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Orbital Period',
                  value: 'About 11.2 Earth days',
                ),
                AppTheme.spacing24.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppTheme.radius14),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                      ),
                      AppTheme.spacing12.horizontalSpace,
                      Expanded(
                        child: Text(
                          'Scientists have not confirmed whether this '
                          'planet has an atmosphere or supports life. '
                          'Habitability remains uncertain.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
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

class _FactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _FactCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radius14),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          AppTheme.spacing16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppTheme.spacing4.verticalSpace,
                Text(value, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
