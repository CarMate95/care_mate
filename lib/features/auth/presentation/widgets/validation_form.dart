import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_manager.dart';
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
              title: TextManager.validationPass1,
            ),
            CustomNewPassValidate(
              isValidate: cubit.hasSpecialChar,
              title: TextManager.validationPass2,
            ),
            CustomNewPassValidate(
              isValidate: cubit.hasUppercase,
              title: TextManager.validationPass3,
            ),
          ],
        );
      },
    );
  }
}
