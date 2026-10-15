import 'package:cosmo/app/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../bloc/exoplanet_bloc.dart';
import '../bloc/exoplanet_event.dart';
import '../bloc/exoplanet_state.dart';
import '../data/models/exoplanet_model.dart';

class ExoplanetsPage extends StatelessWidget {
  const ExoplanetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exoplanets)),
      body: SafeArea(
        child: BlocBuilder<ExoplanetBloc, ExoplanetState>(
          builder: (context, state) {
            if (state.status == ExoplanetStatus.loading ||
                state.status == ExoplanetStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ExoplanetStatus.failure &&
                state.exoplanets.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacing20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 42),
                      AppTheme.spacing12.verticalSpace,
                      Text(
                        state.errorMessage ?? 'Unable to load exoplanets.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      AppTheme.spacing16.verticalSpace,
                      FilledButton(
                        onPressed: () {
                          context.read<ExoplanetBloc>().add(
                            const ExoplanetsRequested(),
                          );
                        },
                        child: Text(l10n.tryAgain),
                      ),
                    ],
                  ),
                ),
              );
            }

            final planets = state.exoplanets;

            if (planets.isEmpty) {
              return Center(
                child: Text(
                  'No exoplanets found.',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification ||
                    notification is ScrollEndNotification) {
                  if (notification.metrics.extentAfter < 300 &&
                      state.hasMore &&
                      !state.isLoadingMore &&
                      state.status == ExoplanetStatus.success) {
                    context.read<ExoplanetBloc>().add(
                      const MoreExoplanetsRequested(),
                    );
                  }
                }

                return false;
              },
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
                              type:
                                  planet.discoveryMethod ??
                                  'Discovery method unknown',
                              distance: _formatDistance(planet),
                              description: _formatPlanetFacts(planet),
                              color: _planetColor(index),
                              icon: Icons.public,
                              onTap: () {
                                context.pushNamed(
                                  RouteNames.exoplanetDetails,
                                  extra: planet,
                                );
                              },
                            ),
                          ),
                        );
                      }, childCount: planets.length),
                    ),
                  ),

                  // Loading indicator for the next page.
                  if (state.isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(AppTheme.spacing24),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),

                  // Retry option if loading more planets fails.
                  if (!state.isLoadingMore &&
                      state.errorMessage != null &&
                      planets.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.spacing20),
                        child: Column(
                          children: [
                            Text(
                              state.errorMessage!,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium,
                            ),
                            AppTheme.spacing12.verticalSpace,
                            OutlinedButton(
                              onPressed: () {
                                context.read<ExoplanetBloc>().add(
                                  const MoreExoplanetsRequested(),
                                );
                              },
                              child: Text(l10n.tryAgain),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppTheme.spacing24),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static String _formatDistance(ExoplanetModel planet) {
    final distance = planet.distanceLightYears;

    if (distance == null) return 'Distance unavailable';

    return '${distance.toStringAsFixed(2)} light-years away';
  }

  static String _formatPlanetFacts(ExoplanetModel planet) {
    final facts = <String>[];

    if (planet.radius != null) {
      facts.add('Radius: ${planet.radius!.toStringAsFixed(2)} Earth radii');
    }

    if (planet.orbitalPeriod != null) {
      facts.add(
        'Orbital period: '
        '${planet.orbitalPeriod!.toStringAsFixed(2)} days',
      );
    }

    return facts.isEmpty ? 'Measurements unavailable' : facts.join(' · ');
  }

  static Color _planetColor(int index) {
    const colors = [
      Color(0xFF4F8EF7),
      Color(0xFF8B5CF6),
      Color(0xFFF59E0B),
      Color(0xFF14B8A6),
    ];

    return colors[index % colors.length];
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
