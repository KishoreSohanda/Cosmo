import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:cosmo/features/home/bloc/home_bloc.dart';
import 'package:cosmo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.greetingPeriod != current.greetingPeriod,
      builder: (context, state) {
        final greeting = switch (state.greetingPeriod) {
          HomeGreetingPeriod.morning => l10n.goodMorningExplorer,
          HomeGreetingPeriod.afternoon => l10n.goodAfternoonExplorer,
          HomeGreetingPeriod.evening => l10n.goodEveningExplorer,
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                greeting,
                key: ValueKey(state.greetingPeriod),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            6.verticalSpace,
            Text(
              l10n.exploreTheUniverse,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
