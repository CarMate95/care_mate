import 'package:flutter/material.dart';

import 'color_manager.dart';

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorManager.whiteBackground,
    // colorScheme: const ColorScheme.light(
    //   primary: ColorManager.primaryColor,
    //   onPrimary: ColorManager.lightPrimaryColor,
    //   secondary: ColorManager.grey,
    //   onSecondary: ColorManager.white,
    //   tertiary: ColorManager.white,
    //   onTertiary: ColorManager.lightBlack,
    // ),
  );

  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.black,
  );
}
