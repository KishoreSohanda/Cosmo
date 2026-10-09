import 'package:cosmo/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';

class ExoplanetsPage extends StatelessWidget {
  const ExoplanetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final planets = [
      (
        name: 'Proxima Centauri b',
        type: 'Terrestrial',
        distance: '4.24 light-years away',
        description: 'A planet orbiting the closest star to our Solar System.',
        color: const Color(0xFF4F8EF7),
        icon: Icons.public,
      ),
      (
        name: 'Kepler-186f',
        type: 'Terrestrial',
        distance: 'About 500 light-years away',
        description:
            'An Earth-sized planet orbiting within its star’s habitable zone.',
        color: const Color(0xFF8B5CF6),
        icon: Icons.language,
      ),
      (
        name: '51 Pegasi b',
        type: 'Hot Jupiter',
        distance: 'About 50 light-years away',
        description: 'A gas giant orbiting very close to its host star.',
        color: const Color(0xFFF59E0B),
        icon: Icons.blur_circular,
      ),
      (
        name: 'TRAPPIST-1e',
        type: 'Terrestrial',
        distance: 'About 40 light-years away',
        description: 'One of seven known planets orbiting the TRAPPIST-1 star.',
        color: const Color(0xFF14B8A6),
        icon: Icons.circle,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exoplanets)),
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
                  l10n.exoplanetsDescription,
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
                  final planet = planets[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == planets.length - 1
                          ? 0
                          : AppTheme.spacing16,
                    ),
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey(planet.name),
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
                      child: _ExoplanetCard(
                        name: planet.name,
                        type: planet.type,
                        distance: planet.distance,
                        description: planet.description,
                        color: planet.color,
                        icon: planet.icon,
                        onTap: () {
                          context.pushNamed(RouteNames.exoplanetDetails);
                        },
                      ),
                    ),
                  );
                }, childCount: planets.length),
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

class _ExoplanetCard extends StatelessWidget {
  final String name;
  final String type;
  final String distance;
  final String description;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _ExoplanetCard({
    required this.name,
    required this.type,
    required this.distance,
    required this.description,
    required this.color,
    required this.icon,
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
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      color.withValues(alpha: 0.9),
                      color.withValues(alpha: 0.25),
                      color.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: Icon(icon, size: 38, color: Colors.white),
              ),
              AppTheme.spacing16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: theme.textTheme.titleMedium),
                    AppTheme.spacing4.verticalSpace,
                    Text(
                      type,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: color,
                      ),
                    ),
                    AppTheme.spacing8.verticalSpace,
                    Text(distance, style: theme.textTheme.bodySmall),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
