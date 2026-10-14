import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:cosmo/core/utils/date_utils.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../data/models/apod_model.dart';

class ApodDetailsPage extends StatelessWidget {
  final ApodModel apod;

  const ApodDetailsPage({required this.apod, super.key});

  String _plainText(String html) {
    return html
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p\s*>', caseSensitive: false), '\n\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&#8217;', '’')
        .replaceAll('&#8211;', '–')
        .replaceAll('&#8212;', '—')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.textPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'apod-${apod.date}',
                child: CachedNetworkImage(
                  imageUrl: apod.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      color: AppTheme.surface,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      color: AppTheme.surface,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TweenAnimationBuilder<double>(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing24,
                  AppTheme.spacing20,
                  AppTheme.spacing32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(apod.title, style: theme.textTheme.headlineLarge),
                    AppTheme.spacing8.verticalSpace,
                    Text(
                      DateTimeUtils.formatDate(
                        apod.date,
                        locale: Localizations.localeOf(context).languageCode,
                      ),
                      style: theme.textTheme.bodyMedium,
                    ),
                    AppTheme.spacing24.verticalSpace,
                    Text(
                      _plainText(apod.explanation),
                      style: theme.textTheme.bodyLarge,
                    ),
                    if (apod.imageDescription?.isNotEmpty == true) ...[
                      AppTheme.spacing24.verticalSpace,
                      Text(
                        apod.imageDescription!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
