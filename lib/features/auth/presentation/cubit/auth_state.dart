part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

// signup states
final class AuthLoadingSignUp extends AuthState {}

final class AuthSuccessSignUp extends AuthState {}

final class AuthErrorSignUp extends AuthState {
  final String message;

  AuthErrorSignUp({required this.message});
}

// login states
final class AuthLoadingLogin extends AuthState {}

final class AuthSuccessLogin extends AuthState {}

final class AuthErrorLogin extends AuthState {
  final String message;

  AuthErrorLogin({required this.message});
}

// forget password
final class AuthLoadingForgetPassword extends AuthState {}

final class AuthSuccessForgetPassword extends AuthState {}

final class AuthErrorForgetPassword extends AuthState {
  final String message;

  AuthErrorForgetPassword({required this.message});
}

// verify otp
final class AuthLoadingOTP extends AuthState {}

final class AuthSuccessOTP extends AuthState {}

final class AuthErrorOTP extends AuthState {
  final String message;

  AuthErrorOTP({required this.message});
}

// change password
final class AuthLoadingChangePassword extends AuthState {}

final class AuthSuccessChangePassword extends AuthState {}

final class AuthErrorChangePassword extends AuthState {
  final String message;

  AuthErrorChangePassword({required this.message});
}