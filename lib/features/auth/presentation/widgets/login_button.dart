import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessLogin) {
          showScaffoldMessage(
            context,
            message: TextManager.loginSuccessfully.tr(),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageName.layoutScreen,
            (route) => false,
          );
        } else if (state is AuthErrorLogin) {
          showScaffoldMessage(context, message: state.message);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoadingLogin,
          onPressed: onPressed,
          text: TextManager.login,
        );
      },
    );
  }
}
