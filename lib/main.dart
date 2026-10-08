import 'package:cosmo/features/settings/bloc/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    BlocProvider(create: (_) => AppSettingsBloc(), child: const CosmoApp()),
  );
}

class CosmoApp extends StatelessWidget {
  const CosmoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<AppSettingsBloc>().state;

    return MaterialApp.router(
      title: 'Cosmo',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsState.themeMode,

      locale: settingsState.language.locale,

      routerConfig: AppRouter.router,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'), Locale('hi')],
    );
  }
}
