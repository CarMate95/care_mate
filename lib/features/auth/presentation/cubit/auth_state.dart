part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

// final class AuthLoading extends AuthState {}

// final class AuthSuccess extends AuthState {}

// final class AuthError extends AuthState {
//   final String message;

//   AuthError({required this.message});
// }

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
