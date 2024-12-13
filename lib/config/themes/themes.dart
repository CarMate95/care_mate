import 'package:flutter/material.dart';

import 'color_manager.dart';

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.whiteBackground,
    colorScheme: const ColorScheme.light(
      primary: ColorManager.primaryColor,
      onPrimary: ColorManager.primaryColor,
      secondary: ColorManager.black,
      tertiary: ColorManager.lightGrey,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.black,
    colorScheme: const ColorScheme.dark(
      primary: ColorManager.primaryColor,
      onPrimary: ColorManager
          .lightPrimaryColor, // lightPrimary in dark , primary in light
      secondary: ColorManager.white, // white in dark , black in light
      tertiary: ColorManager.darkGrey, // darkGrey in dark , lightGrey in light
    ),
  );
}
