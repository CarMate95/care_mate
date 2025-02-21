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

