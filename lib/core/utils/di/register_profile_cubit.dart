import 'package:car_mate/core/utils/di/di.dart';

import '../../../features/profile/profile_cubit/profile_cubit.dart';

// regiser profile cubit
void registerProfileCubit() {
  sl.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(),
  );
}
