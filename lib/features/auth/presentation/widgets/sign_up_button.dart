import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_manager.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessSignUp) {
          Navigator.pop(context);
          showScaffoldMessage(context, message: "SignUp successfully");
        }
        if (state is AuthErrorSignUp) {
          showScaffoldMessage(context, message: state.message);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoadingSignUp,
          onPressed: onPressed,
          // () {
          //   setState(() {
          //     startValidation = true;
          //   });
          //   if (!formKey.currentState!.validate()) return;
          // },
          text: TextManager.signUp,
        );
      },
    );
  }
}
