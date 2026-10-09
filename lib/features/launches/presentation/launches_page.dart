import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';

class LaunchesPage extends StatelessWidget {
  const LaunchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    const upcomingLaunches = [
      _Launch(
        name: 'Falcon 9 Block 5',
        mission: 'SDA Tranche 1',
        date: 'Oct 5, 2026',
        provider: 'SpaceX',
      ),
      _Launch(
        name: 'Nuri',
        mission: 'NeonSat-2 to 6',
        date: 'Oct 7, 2026',
        provider: 'KSLV-II',
      ),
      _Launch(
        name: 'Ariane 6',
        mission: 'JUICE',
        date: 'Apr 2026',
        provider: 'ESA',
      ),
    ];

    const pastLaunches = [
      _Launch(
        name: 'Falcon 9 Block 5',
        mission: 'Satellite Deployment',
        date: 'Sep 28, 2026',
        provider: 'SpaceX',
      ),
      _Launch(
        name: 'Atlas V',
        mission: 'Kuiper Mission',
        date: 'Sep 20, 2026',
        provider: 'ULA',
      ),
      _Launch(
        name: 'Ariane 6',
        mission: 'Satellite Mission',
        date: 'Sep 15, 2026',
        provider: 'ESA',
      ),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.launches),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacing20,
                AppTheme.spacing8,
                AppTheme.spacing20,
                AppTheme.spacing12,
              ),
              child: Container(
                height: 44,
                padding: const EdgeInsets.all(AppTheme.spacing4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.55,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radius20),
                ),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radius20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                  labelStyle: theme.textTheme.labelLarge,
                  tabs: [
                    Tab(text: l10n.upcoming),
                    Tab(text: l10n.past),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _LaunchList(launches: upcomingLaunches),
              _LaunchList(launches: pastLaunches),
            ],
          ),
        ),
      ),
    );
  }
}

class _Launch {
  final String name;
  final String mission;
  final String date;
  final String provider;

  const _Launch({
    required this.name,
    required this.mission,
    required this.date,
    required this.provider,
  });
}

class _LaunchList extends StatelessWidget {
  final List<_Launch> launches;

  const _LaunchList({required this.launches});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (launches.isEmpty) {
      return Center(
        child: Text(l10n.noLaunchesFound, style: theme.textTheme.bodyMedium),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacing20,
        AppTheme.spacing12,
        AppTheme.spacing20,
        AppTheme.spacing24,
      ),
      itemCount: launches.length,
      separatorBuilder: (context, index) => AppTheme.spacing12.verticalSpace,
      itemBuilder: (context, index) {
        final launch = launches[index];

        return TweenAnimationBuilder<double>(
          key: ValueKey('${launch.name}-${launch.mission}'),
          tween: Tween(begin: 0, end: 1),
          duration: AppAnimations.normal,
          curve: AppAnimations.standard,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 10 * (1 - value)),
                child: child,
              ),
            );
          },
          child: _LaunchCard(launch: launch),
        );
      },
    );
  }
}

class _LaunchCard extends StatelessWidget {
  final _Launch launch;

  const _LaunchCard({required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppTheme.radius14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.pushNamed(RouteNames.launchDetails);
        },
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radius14),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 76,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: Icon(
                  Icons.rocket_launch_outlined,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
              ),
              AppTheme.spacing12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      launch.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    AppTheme.spacing4.verticalSpace,
                    Text(
                      launch.mission,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      '${launch.date} · ${launch.provider}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AppTheme.spacing4.horizontalSpace,
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
