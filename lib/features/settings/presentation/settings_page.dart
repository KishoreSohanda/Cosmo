import 'package:cosmo/core/widgets/divider.dart';
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
    return BlocSelector<AppSettingsBloc, AppSettingsState, Locale>(
      selector: (state) => state.locale,
      builder: (context, locale) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(
              locale.languageCode == 'hi' ? l10n.hindi : l10n.english,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showLanguageSelector(context, l10n, locale, appSettingsBloc);
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile<ThemeMode>(
                title: Text(l10n.dark),
                value: ThemeMode.dark,
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(ThemeChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text(l10n.light),
                value: ThemeMode.light,
                groupValue: currentTheme,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(ThemeChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
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
    Locale currentLocale,
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              RadioListTile<Locale>(
                title: Text(l10n.english),
                value: const Locale('en'),
                groupValue: currentLocale,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(LanguageChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
              ),
              RadioListTile<Locale>(
                title: Text(l10n.hindi),
                value: const Locale('hi'),
                groupValue: currentLocale,
                onChanged: (value) {
                  if (value == null) return;

                  appSettingsBloc.add(LanguageChanged(value));

                  Navigator.pop(bottomSheetContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
