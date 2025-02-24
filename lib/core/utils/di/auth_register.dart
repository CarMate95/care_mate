import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:car_mate/core/utils/di/di.dart';
import 'package:car_mate/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_mate/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:car_mate/features/auth/domain/usecases/login_use_case.dart';
import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../features/auth/domain/repositories/auth_repo.dart';
import '../../../features/auth/domain/usecases/forget_password_use_case.dart';
import '../../../features/auth/domain/usecases/signup_use_case.dart';
import '../../../features/auth/domain/usecases/verify_otp_use_case.dart';

// register signup
void authRegister() {
  // auth repo instance
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      AuthRemoteDataSource(
        sl.get<DioConsumer>(),
      ),
    ),
  );

  // auth cubit
  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      SignupUseCase(
        sl.get<AuthRepo>(),
      ),
      LoginUseCase(
        sl.get<AuthRepo>(),
      ),
      ForgetPasswordUseCase(
        sl.get<AuthRepo>(),
      ),
      VerifyOtpUseCase(
        sl.get<AuthRepo>(),
      ),
    ),
  );
}
