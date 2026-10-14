import 'package:cosmo/app/router/route_names.dart';
import 'package:cosmo/features/nasa_images/bloc/nasa_images_bloc.dart';
import 'package:cosmo/features/nasa_images/bloc/nasa_images_event.dart';
import 'package:cosmo/features/nasa_images/bloc/nasa_images_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../l10n/app_localizations.dart';

class NasaImagesPage extends StatelessWidget {
  const NasaImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nasaImages)),
      body: SafeArea(
        child: BlocBuilder<NasaImagesBloc, NasaImagesState>(
          builder: (context, state) {
            return CustomScrollView(
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
                      l10n.nasaImagesDescription,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                if (state.status == NasaImagesStatus.loading &&
                    state.images.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == NasaImagesStatus.failure &&
                    state.images.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _NasaImagesMessage(
                      message:
                          state.errorMessage ?? 'Failed to load NASA images.',
                      buttonText: l10n.tryAgain,
                      onPressed: () {
                        context.read<NasaImagesBloc>().add(
                          const NasaImagesRequested(),
                        );
                      },
                    ),
                  )
                else if (state.images.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _NasaImagesMessage(message: 'No NASA images found.'),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing20,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppTheme.spacing12,
                            mainAxisSpacing: AppTheme.spacing16,
                            childAspectRatio: 0.72,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index >= state.images.length - 4 &&
                            state.hasMore &&
                            !state.isLoadingMore) {
                          context.read<NasaImagesBloc>().add(
                            const NasaImagesNextPageRequested(),
                          );
                        }

                        final item = state.images[index];

                        return TweenAnimationBuilder<double>(
                          key: ValueKey(item.nasaId),
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
                          child: _NasaImageCard(
                            title: item.title,
                            imageUrl: item.thumbnailUrl,
                            onTap: () {
                              context.pushNamed(
                                RouteNames.nasaImageDetails,
                                extra: {
                                  'image': item,
                                  'bloc': context.read<NasaImagesBloc>(),
                                },
                              );
                            },
                          ),
                        );
                      }, childCount: state.images.length),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacing20),
                      child: Center(
                        child: state.isLoadingMore
                            ? const CircularProgressIndicator()
                            : state.errorMessage != null
                            ? TextButton(
                                onPressed: () {
                                  context.read<NasaImagesBloc>().add(
                                    const NasaImagesNextPageRequested(),
                                  );
                                },
                                child: Text(l10n.tryAgain),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.spacing24),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NasaImagesMessage extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _NasaImagesMessage({
    required this.message,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            if (buttonText != null && onPressed != null) ...[
              const SizedBox(height: AppTheme.spacing12),
              FilledButton(onPressed: onPressed, child: Text(buttonText!)),
            ],
          ],
        ),
      ),
    );
  }
}

class _NasaImageCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _NasaImageCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppTheme.radius14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return ColoredBox(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    width: double.infinity,
                    child: ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image_outlined, size: 36),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
