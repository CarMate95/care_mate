import 'package:car_mate/core/helpers/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeCubitInitial());
  static ThemeCubit get(context) => BlocProvider.of<ThemeCubit>(context);

  static const String _darkThemKey = 'themeMode';

  static ThemeMode themeMode = CacheHelper.getBoolData(_darkThemKey) == null
      ? ThemeMode.dark
      : CacheHelper.getBoolData(_darkThemKey)!
          ? ThemeMode.dark
          : ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeCubitToggled());
    CacheHelper.set(
      key: _darkThemKey,
      value: themeMode == ThemeMode.dark,
    );
  }
}
