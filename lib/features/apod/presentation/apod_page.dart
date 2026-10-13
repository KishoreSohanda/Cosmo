import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../bloc/apod_bloc.dart';
import '../bloc/apod_event.dart';
import '../bloc/apod_state.dart';
import '../data/models/apod_model.dart';

class ApodPage extends StatefulWidget {
  const ApodPage({super.key});

  @override
  State<ApodPage> createState() => _ApodPageState();
}

class _ApodPageState extends State<ApodPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 400) {
      context.read<ApodBloc>().add(const ApodNextPageRequested());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.astronomyPictureOfTheDay)),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing8,
                  AppTheme.spacing20,
                  AppTheme.spacing24,
                ),
                child: Text(
                  l10n.exploreApodDescription,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            BlocBuilder<ApodBloc, ApodState>(
              builder: (context, state) {
                switch (state.status) {
                  case ApodStatus.initial:
                  case ApodStatus.loading:
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    );

                  case ApodStatus.failure:
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.spacing24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.cloud_off_outlined, size: 48),
                              AppTheme.spacing16.verticalSpace,
                              Text(
                                state.errorMessage ??
                                    'Unable to load astronomy pictures.',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium,
                              ),
                              AppTheme.spacing16.verticalSpace,
                              FilledButton(
                                onPressed: () {
                                  context.read<ApodBloc>().add(
                                    const ApodListRequested(),
                                  );
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  case ApodStatus.success:
                    if (state.apods.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No astronomy pictures available.'),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing20,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index == state.apods.length) {
                              if (state.isLoadingMore) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppTheme.spacing24,
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (state.errorMessage != null) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppTheme.spacing16,
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        context.read<ApodBloc>().add(
                                          const ApodNextPageRequested(),
                                        );
                                      },
                                      child: const Text('Try loading more'),
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox.shrink();
                            }

                            final item = state.apods[index];

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == state.apods.length - 1
                                    ? 0
                                    : AppTheme.spacing20,
                              ),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: AppAnimations.normal,
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
                                child: _ApodCard(
                                  apod: item,
                                  onTap: () {
                                    context.pushNamed(
                                      RouteNames.apodDetails,
                                      extra: item,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          childCount:
                              state.apods.length +
                              (state.isLoadingMore || state.errorMessage != null
                                  ? 1
                                  : 0),
                        ),
                      ),
                    );
                }
              },
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

class _ApodCard extends StatelessWidget {
  final ApodModel apod;
  final VoidCallback onTap;

  const _ApodCard({required this.apod, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(AppTheme.radius20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'apod-${apod.date}',
              child: CachedNetworkImage(
                imageUrl: apod.thumbnailUrl,
                width: double.infinity,
                height: 210,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 210,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: double.infinity,
                    height: 210,
                    color: theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image_outlined, size: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apod.date, style: theme.textTheme.labelMedium),
                  AppTheme.spacing8.verticalSpace,
                  Text(apod.title, style: theme.textTheme.titleMedium),
                  AppTheme.spacing8.verticalSpace,
                  Row(
                    children: [
                      Text(
                        l10n.viewDetails,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      AppTheme.spacing4.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
