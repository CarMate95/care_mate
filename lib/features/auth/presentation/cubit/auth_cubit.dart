import 'dart:async';

import 'package:car_mate/core/helpers/cache_helper.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:car_mate/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:car_mate/features/auth/domain/usecases/login_use_case.dart';
import 'package:car_mate/features/auth/domain/usecases/signup_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/di/di.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/verify_otp_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signupUseCase,
    this._loginUseCase,
    this._forgetPasswordUseCase,
    this._verifyOtpUseCase,
  ) : super(AuthInitial());
  static AuthCubit get(context) => sl.get<AuthCubit>();
  final SignupUseCase _signupUseCase;
  final LoginUseCase _loginUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;

  String emailOtp = '';
  TextEditingController otpController = TextEditingController();

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

  // forgetPassword
  Future<void> forgetPassword({required String email}) async {
    emailOtp = email;
    emit(AuthLoadingForgetPassword());
    final result = await _forgetPasswordUseCase(email: email);
    result.fold(
      (failure) => emit(AuthErrorForgetPassword(message: failure.message)),
      (result) => emit(AuthSuccessForgetPassword()),
    );
  }
  
  // onChangeOtp
  void Function(String)? onChangeOtp() {
    return (value) {
      if (value.length == 6) {
        verifyOtp(otp: value);
      }
    };
  }

  // verifyOtp
  Future<void> verifyOtp({required String otp}) async {
    emit(AuthLoadingOTP());
    final result = await _verifyOtpUseCase(email: emailOtp, otp: otp);
    result.fold(
      (failure) => emit(AuthErrorOTP(message: failure.message)),
      (result) => emit(AuthSuccessOTP()),
    );
  }
}
