import 'package:cosmo/core/extensions/spacing_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.goodEveningExplorer,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        6.verticalSpace,
        Text(
          l10n.exploreTheUniverse,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
