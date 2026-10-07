part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent {}

class ThemeChanged extends AppSettingsEvent {
  final ThemeMode themeMode;

  ThemeChanged(this.themeMode);
}

class LanguageChanged extends AppSettingsEvent {
  final Locale locale;

  LanguageChanged(this.locale);
}
