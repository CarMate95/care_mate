import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/password_validation/password_validation_cubit.dart';
import 'custom_new_pass_validate.dart';

class ValidationForm extends StatelessWidget {
  const ValidationForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PasswordValidationCubit.get(context);
    return BlocBuilder<PasswordValidationCubit, PasswordValidationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNewPassValidate(
              isValidate: cubit.hasMinLength,
              title: 'At least 8 characters',
            ),
            CustomNewPassValidate(
              isValidate: cubit.hasSpecialChar,
              title: r'Include at least one special character (e.g., @, #, $).',
            ),
            CustomNewPassValidate(
              isValidate: cubit.hasUppercase,
              title: 'Include at least one uppercase letter (A-Z).',
            ),
          ],
        );
      },
    );
  }
}
