part of 'app_settings_bloc.dart';

class AppSettingsState {
  final ThemeMode themeMode;
  final AppLanguage language;

  const AppSettingsState({
    this.themeMode = ThemeMode.dark,
    this.language = AppLanguage.english,
  });

  AppSettingsState copyWith({ThemeMode? themeMode, AppLanguage? language}) {
    return AppSettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }
}
