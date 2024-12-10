import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme_cubit/theme_cubit_cubit.dart';

extension ConfigExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);

  /// in light is white , in dark is black
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// in light is primary , in dark is primary
  Color get primaryColor => Theme.of(this).primaryColor;

  /// in light is primary , in dark is lightPrimary
  Color get onPrimayColor => Theme.of(this).colorScheme.onPrimary;

  /// in light is black , in dark is white
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  /// in light is lightGrey , in dark is darkGrey
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;

  /// change theme
  void changeTheme() {
    ThemeCubit.get(this).toggleTheme();
  }

  /// change language
  void changeLanguage() {
    if (locale.languageCode == 'ar') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('ar'));
    }
  }
}
