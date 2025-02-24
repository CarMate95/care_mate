import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/page_name.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';

class VerifyOtpButton extends StatelessWidget {
  final bool isRegisterFlow;
  const VerifyOtpButton({super.key, required this.isRegisterFlow});

  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorOTP) {
          showScaffoldMessage(context, message: state.message);
        } else if (state is AuthSuccessOTP) {
          showScaffoldMessage(context, message: TextManager.success.tr());
          VerifyOtpCubit.of(context).stopTimer();
          Navigator.pushNamed(context, PageName.newPasswordScreen);
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is AuthLoadingOTP,
          enabled: authCubit.otpController.text.length == 6,
          text: TextManager.verify,
          onPressed: () {
            // cubit.verifyOtp(isRegisterFlow);
            // Navigator.pushNamed(context, PageName.newPasswordScreen);
          },
        );
      },
    );
  }
}
