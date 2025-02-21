import 'package:car_mate/core/helpers/cache_helper.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:car_mate/features/auth/domain/usecases/login_use_case.dart';
import 'package:car_mate/features/auth/domain/usecases/signup_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._signupUseCase, this._loginUseCase) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  final SignupUseCase _signupUseCase;
  final LoginUseCase _loginUseCase;

  // signup
  Future<void> signup({required UserEntity user}) async {
    emit(AuthLoadingSignUp());
    final result = await _signupUseCase(user: user);
    result.fold(
      (failure) => emit(AuthErrorSignUp(message: failure.message)),
      (result) => emit(AuthSuccessSignUp()),
    );
  }

  // login
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingLogin());
    final result = await _loginUseCase(email: email, password: password);
    result.fold((failure) => emit(AuthErrorLogin(message: failure.message)),
        (result) {
      CacheHelper.set(key: 'token', value: result);
      kprint("Token: ${ConstantsManager.token}");
      emit(AuthSuccessLogin());
    });
  }
}
