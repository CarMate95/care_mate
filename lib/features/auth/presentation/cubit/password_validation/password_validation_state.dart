part of 'password_validation_cubit.dart';

sealed class PasswordValidationState {}

final class PasswordValidationInitial extends PasswordValidationState {}

class PasswordValidationChanged extends PasswordValidationState {}
