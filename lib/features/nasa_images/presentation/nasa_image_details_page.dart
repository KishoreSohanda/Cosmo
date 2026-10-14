import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmo/core/utils/date_utils.dart';
import 'package:cosmo/features/nasa_images/data/models/nasa_image_model.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';

class NasaImageDetailsPage extends StatelessWidget {
  final NasaImageModel image;

  const NasaImageDetailsPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final details = <MapEntry<String, String>>[
      MapEntry(
        l10n.nasaImageDetailsDateCreated,
        DateTimeUtils.formatDate(
          image.dateCreated,
          locale: Localizations.localeOf(context).languageCode,
        ),
      ),
      MapEntry(l10n.nasaImageDetailsNasaCenter, image.center ?? ''),
      MapEntry(l10n.nasaImageDetailsCreator, image.secondaryCreator ?? ''),
      MapEntry(l10n.nasaImageDetailsPhotographer, image.photographer ?? ''),
    ].where((item) => item.value.trim().isNotEmpty).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _ImageHeader(image: image),
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
                  child: Text(
                    image.title,
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
                AppTheme.spacing12.verticalSpace,
                Text(
                  l10n.nasaImageLibrary,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (image.description.trim().isNotEmpty) ...[
                  AppTheme.spacing24.verticalSpace,
                  Text(
                    l10n.nasaImageDetailsAbout,
                    style: theme.textTheme.titleLarge,
                  ),
                  AppTheme.spacing8.verticalSpace,
                  Text(
                    image.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (image.keywords.isNotEmpty) ...[
                  AppTheme.spacing24.verticalSpace,
                  Text(
                    l10n.nasaImageDetailsKeywords,
                    style: theme.textTheme.titleLarge,
                  ),
                  AppTheme.spacing12.verticalSpace,
                  Wrap(
                    spacing: AppTheme.spacing8,
                    runSpacing: AppTheme.spacing8,
                    children: image.keywords
                        .map((keyword) => Chip(label: Text(keyword)))
                        .toList(),
                  ),
                ],
                if (details.isNotEmpty) ...[
                  AppTheme.spacing24.verticalSpace,
                  Text(
                    l10n.nasaImageDetailsImageInformation,
                    style: theme.textTheme.titleLarge,
                  ),
                  AppTheme.spacing16.verticalSpace,
                  ...details.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppTheme.spacing12,
                      ),
                      child: _InfoRow(label: item.key, value: item.value),
                    ),
                  ),
                ],
                AppTheme.spacing24.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  final NasaImageModel image;

  const _ImageHeader({required this.image});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final url = image.smallImageUrl.isNotEmpty
        ? image.smallImageUrl
        : image.mediumImageUrl.isNotEmpty
        ? image.mediumImageUrl
        : image.thumbnailUrl.isNotEmpty
        ? image.thumbnailUrl
        : image.originalImageUrl;

    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: url.isEmpty
          ? const Center(child: Icon(Icons.broken_image_outlined, size: 48))
          : CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              fadeInDuration: AppAnimations.fast,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.broken_image_outlined, size: 48),
              ),
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
          width: 120,
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
