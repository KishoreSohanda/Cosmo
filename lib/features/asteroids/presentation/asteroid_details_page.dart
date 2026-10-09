import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';

class AsteroidDetailsPage extends StatelessWidget {
  const AsteroidDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asteroid Details')),
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
                        color: AppTheme.secondary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.public,
                        color: AppTheme.secondary,
                        size: 28,
                      ),
                    ),
                    AppTheme.spacing20.verticalSpace,
                    Text(
                      '2026 AB1',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      'Near-Earth Object',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            AppTheme.spacing24.verticalSpace,
            Text(
              'Close Approach',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppTheme.spacing16.verticalSpace,
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Date',
              value: 'October 9, 2026',
            ),
            _InfoRow(
              icon: Icons.straighten_outlined,
              title: 'Distance',
              value: '4.2 million km',
            ),
            _InfoRow(
              icon: Icons.speed_outlined,
              title: 'Velocity',
              value: '18.6 km/s',
            ),
            AppTheme.spacing24.verticalSpace,
            Text(
              'Asteroid Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            AppTheme.spacing12.verticalSpace,
            Text(
              '2026 AB1 is being monitored as it makes a close approach '
              'to Earth. Close approach data helps track the position, '
              'distance, and velocity of near-Earth objects.',
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
          Icon(icon, size: 20, color: AppTheme.secondary),
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
