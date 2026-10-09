import 'package:cosmo/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';

class AsteroidsPage extends StatelessWidget {
  const AsteroidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final asteroids = [
      (
        name: '2026 AB1',
        date: 'October 9, 2026',
        distance: '4.2 million km',
        diameter: '18.6 m',
        velocity: '12.4 km/s',
        risk: 'Low',
        color: const Color(0xFF60A5FA),
      ),
      (
        name: '2025 QX9',
        date: 'October 12, 2026',
        distance: '6.8 million km',
        diameter: '42 m',
        velocity: '9.7 km/s',
        risk: 'Low',
        color: const Color(0xFF34D399),
      ),
      (
        name: '2024 YR4',
        date: 'December 22, 2026',
        distance: 'Variable',
        diameter: 'Estimated 40–90 m',
        velocity: 'Unknown',
        risk: 'Monitor',
        color: const Color(0xFFFBBF24),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.asteroids)),
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
                  'Track near-Earth objects and explore their close approaches.',
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
                  final asteroid = asteroids[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == asteroids.length - 1
                          ? 0
                          : AppTheme.spacing16,
                    ),
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey(asteroid.name),
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
                      child: _AsteroidListCard(
                        name: asteroid.name,
                        date: asteroid.date,
                        distance: asteroid.distance,
                        diameter: asteroid.diameter,
                        velocity: asteroid.velocity,
                        risk: asteroid.risk,
                        color: asteroid.color,
                        onTap: () {
                          context.pushNamed(RouteNames.asteroidDetails);
                        },
                      ),
                    ),
                  );
                }, childCount: asteroids.length),
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

class _AsteroidListCard extends StatelessWidget {
  final String name;
  final String date;
  final String distance;
  final String diameter;
  final String velocity;
  final String risk;
  final Color color;
  final VoidCallback onTap;

  const _AsteroidListCard({
    required this.name,
    required this.date,
    required this.distance,
    required this.diameter,
    required this.velocity,
    required this.risk,
    required this.color,
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
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radius20),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.12),
                    ),
                    child: Icon(Icons.blur_on, color: color, size: 30),
                  ),
                  AppTheme.spacing12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: theme.textTheme.titleMedium),
                        AppTheme.spacing4.verticalSpace,
                        Text(
                          'Close approach: $date',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              AppTheme.spacing16.verticalSpace,
              const Divider(height: 1),
              AppTheme.spacing12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: _AsteroidMetric(label: 'Distance', value: distance),
                  ),
                  Expanded(
                    child: _AsteroidMetric(label: 'Diameter', value: diameter),
                  ),
                ],
              ),
              AppTheme.spacing12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: _AsteroidMetric(label: 'Velocity', value: velocity),
                  ),
                  Expanded(
                    child: _AsteroidMetric(
                      label: 'Status',
                      value: risk,
                      valueColor: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AsteroidMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _AsteroidMetric({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        AppTheme.spacing4.verticalSpace,
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(color: valueColor),
        ),
      ],
    );
  }
}
