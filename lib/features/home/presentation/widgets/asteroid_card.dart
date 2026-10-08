import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/extensions/spacing_extensions.dart';

class AsteroidCard extends StatelessWidget {
  final String name;
  final String date;
  final String distance;
  final String velocity;
  final VoidCallback? onTap;

  const AsteroidCard({
    super.key,
    required this.name,
    required this.date,
    required this.distance,
    required this.velocity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: AppAnimations.normal,
      curve: AppAnimations.standard,
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.public, color: AppTheme.secondary),
              ),

              14.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    4.verticalSpace,

                    Text(date, style: Theme.of(context).textTheme.bodySmall),

                    8.verticalSpace,

                    Row(
                      children: [
                        const Icon(
                          Icons.straighten_outlined,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        5.horizontalSpace,
                        Flexible(
                          child: Text(
                            distance,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              12.horizontalSpace,

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    velocity,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppTheme.primary),
                  ),
                  4.verticalSpace,
                  Text('km/s', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
