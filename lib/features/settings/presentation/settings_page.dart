import 'package:cosmo/core/widgets/divider.dart';
import 'package:cosmo/features/settings/models/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/spacing_extensions.dart';
import '../../../l10n/app_localizations.dart';
import '../bloc/app_settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appSettingsBloc = context.read<AppSettingsBloc>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.appearance, style: Theme.of(context).textTheme.titleMedium),

          8.verticalSpace,

          _buildThemeTile(context, l10n, appSettingsBloc),

          12.verticalSpace,

          _buildLanguageTile(context, l10n, appSettingsBloc),

          32.verticalSpace,

          Text(l10n.about, style: Theme.of(context).textTheme.titleMedium),

          8.verticalSpace,

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.aboutCosmo),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const AppDivider(),
                ListTile(
                  leading: const Icon(Icons.api_outlined),
                  title: Text(l10n.apiSources),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const AppDivider(),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(l10n.creditsAndLicenses),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          32.verticalSpace,
          Text(l10n.app, style: Theme.of(context).textTheme.titleMedium),
          8.verticalSpace,
          Card(
            child: ListTile(
              title: Text(l10n.version),
              trailing: Text(
                '1.0.0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeTile(
    BuildContext context,
    AppLocalizations l10n,
    AppSettingsBloc appSettingsBloc,
  ) {
    return BlocSelector<AppSettingsBloc, AppSettingsState, ThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(l10n.theme),
            subtitle: Text(
              themeMode == ThemeMode.dark ? l10n.dark : l10n.light,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showThemeSelector(context, l10n, themeMode, appSettingsBloc);
            },
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    AppLocalizations l10n,
    AppSettingsBloc appSettingsBloc,
  ) {
    return BlocSelector<AppSettingsBloc, AppSettingsState, AppLanguage>(
      selector: (state) => state.language,
      builder: (context, language) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(
              language == AppLanguage.hindi ? l10n.hindi : l10n.english,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showLanguageSelector(context, l10n, language, appSettingsBloc);
            },
          ),
        );
      },
    );
  }

  void _showThemeSelector(
    BuildContext context,
    AppLocalizations l10n,
    ThemeMode currentTheme,
    AppSettingsBloc appSettingsBloc,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  l10n.theme,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              RadioGroup<ThemeMode>(
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(ThemeChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(l10n.dark),
                      value: ThemeMode.dark,
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(l10n.light),
                      value: ThemeMode.light,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageSelector(
    BuildContext context,
    AppLocalizations l10n,
    AppLanguage currentLanguage,
    AppSettingsBloc appSettingsBloc,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  l10n.language,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              RadioGroup<AppLanguage>(
                groupValue: currentLanguage,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(LanguageChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
                child: Column(
                  children: [
                    RadioListTile<AppLanguage>(
                      title: Text(l10n.english),
                      value: AppLanguage.english,
                    ),
                    RadioListTile<AppLanguage>(
                      title: Text(l10n.hindi),
                      value: AppLanguage.hindi,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
