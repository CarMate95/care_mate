import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/text_manager.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_scaffold_message.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessChangePassword) {
          showScaffoldMessage(
            context,
            message: "Password changed successfully",
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageName.loginScreen,
            (route) => false,
          );
        } else if (state is AuthErrorChangePassword) {
          showScaffoldMessage(context, message: state.message);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoadingChangePassword,
          onPressed: onPressed,
          text: TextManager.resetPassword,
        );
      },
    );
  }
}
