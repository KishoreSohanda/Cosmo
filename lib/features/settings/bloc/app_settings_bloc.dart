import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/app_language.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc() : super(const AppSettingsState()) {
    on<ThemeChanged>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<LanguageChanged>((event, emit) {
      emit(state.copyWith(language: event.language));
    });
  }
}
