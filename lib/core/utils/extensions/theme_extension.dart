import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme_cubit/theme_cubit_cubit.dart';

extension ConfigExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  ThemeData get theme => Theme.of(this);

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  // change theme
  void changeTheme() {
    ThemeCubit.get(this).toggleTheme();
  }

  // change language
  void changeLanguage() {
    if (locale.languageCode == 'ar') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('ar'));
    }
  }
}
