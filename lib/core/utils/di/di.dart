// This the dependency injection file,
// it's responsible for initializing the app and its dependencies.

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:car_mate/core/api/api_consumer.dart';
import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_register.dart';
import 'register_profile_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Api consumer instance
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: Dio(),
    ),
  );

  // dio consumer instance
  sl.registerLazySingleton<DioConsumer>(
    () => DioConsumer(
      dio: Dio(),
    ),
  );

  // Shared preferences instance
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);

  // auth register
  authRegister();

  // profile cubit
  registerProfileCubit();
}
