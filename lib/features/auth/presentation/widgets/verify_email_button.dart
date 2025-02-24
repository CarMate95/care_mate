import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/text_manager.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_scaffold_message.dart';

class VerifyEmailButton extends StatelessWidget {
  const VerifyEmailButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // showScaffoldMessage(context, message: "Test Message");

        if (state is AuthErrorForgetPassword) {
          showScaffoldMessage(context, message: state.message);
        } else if (state is AuthSuccessForgetPassword) {
          showScaffoldMessage(
            context,
            message: TextManager.checkYourEmail.tr(),
          );
          Navigator.pushNamed(context, PageName.verifyOtpScreen);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoadingForgetPassword,
          onPressed: onPressed,
          text: TextManager.sendCode,
        );
      },
    );
  }
}
