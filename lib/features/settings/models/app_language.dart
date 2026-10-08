import 'package:flutter/material.dart';

enum AppLanguage {
  english(Locale('en')),
  hindi(Locale('hi'));

  const AppLanguage(this.locale);

  final Locale locale;
}
