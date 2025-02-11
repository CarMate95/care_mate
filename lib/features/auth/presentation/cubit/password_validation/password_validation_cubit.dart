import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_validation_state.dart';

class PasswordValidationCubit extends Cubit<PasswordValidationState> {
  PasswordValidationCubit() : super(PasswordValidationInitial());
  static PasswordValidationCubit get(context) => BlocProvider.of(context);

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasSpecialChar = false;
  bool isValidate = false;

  void validatePassword(String password) {
    hasMinLength = password.length >= 8;
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    isValidate = hasMinLength && hasUppercase && hasSpecialChar;
    emit(PasswordValidationChanged());
  }
}
