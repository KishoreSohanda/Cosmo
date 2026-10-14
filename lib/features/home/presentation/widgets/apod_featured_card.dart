import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmo/app/router/route_names.dart';
import 'package:cosmo/app/theme/app_theme.dart';
import 'package:cosmo/core/animations/app_animations.dart';
import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:cosmo/features/home/bloc/home_bloc.dart';
import 'package:cosmo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cosmo/core/utils/date_utils.dart';

class ApodFeaturedCard extends StatelessWidget {
  const ApodFeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TweenAnimationBuilder<double>(
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
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return _buildPlaceholder(
                child: const CircularProgressIndicator(),
              );

            case HomeStatus.failure:
              return _buildPlaceholder(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 32),
                    12.verticalSpace,
                    Text(
                      l10n.apodLoadError,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    8.verticalSpace,
                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const HomeApodRequested());
                      },
                      child: Text(l10n.tryAgain),
                    ),
                  ],
                ),
              );

            case HomeStatus.success:
              final apod = state.featuredApod!;

              return GestureDetector(
                onTap: () {
                  context.pushNamed(RouteNames.apodDetails, extra: apod);
                },
                child: Hero(
                  tag: 'apod-${apod.date}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: apod.thumbnailUrl,
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
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0xCC050816)],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  apod.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                6.verticalSpace,
                                Text(
                                  DateTimeUtils.formatDate(
                                    apod.date,
                                    locale: Localizations.localeOf(
                                      context,
                                    ).languageCode,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

Widget _buildPlaceholder({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        color: AppTheme.surface,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    ),
  );
}
