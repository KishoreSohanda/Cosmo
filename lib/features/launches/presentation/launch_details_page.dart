import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';

class LaunchDetailsPage extends StatelessWidget {
  const LaunchDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Launch Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.spacing20,
          AppTheme.spacing20,
          AppTheme.spacing20,
          AppTheme.spacing32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
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
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacing20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radius20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppTheme.radius14),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_outlined,
                        color: AppTheme.primary,
                        size: 28,
                      ),
                    ),
                    AppTheme.spacing20.verticalSpace,
                    Text(
                      'Starlink Group 10-25',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      'SpaceX',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            AppTheme.spacing24.verticalSpace,
            Text(
              'Launch Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppTheme.spacing16.verticalSpace,
            _InfoRow(
              icon: Icons.schedule_outlined,
              title: 'Date',
              value: 'October 8, 2026',
            ),
            _InfoRow(
              icon: Icons.flag_outlined,
              title: 'Status',
              value: 'Upcoming',
            ),
            _InfoRow(
              icon: Icons.location_on_outlined,
              title: 'Launch Site',
              value: 'Kennedy Space Center',
            ),
            _InfoRow(
              icon: Icons.business_outlined,
              title: 'Provider',
              value: 'SpaceX',
            ),
            AppTheme.spacing24.verticalSpace,
            Text(
              'About the Mission',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppTheme.spacing12.verticalSpace,
            Text(
              'Starlink Group 10-25 is a planned SpaceX mission to deploy '
              'Starlink satellites into low Earth orbit.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppTheme.primary),
          AppTheme.spacing12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodySmall),
                AppTheme.spacing4.verticalSpace,
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
