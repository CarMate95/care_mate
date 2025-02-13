import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/page_name.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';

class VerifyOtpButton extends StatelessWidget {
  final bool isRegisterFlow;
  const VerifyOtpButton({super.key, required this.isRegisterFlow});

  @override
  Widget build(BuildContext context) {
    var cubit = VerifyOtpCubit.of(context);
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listener: (context, state) {
        // if (state is VerifyOtpSuccessState) {
        //   if (isRegisterFlow) {
        //     showDialog(
        //         context: context,
        //         builder: (context) => CustomSuccessAlertDialoge(
        //               context: context,
        //               onTapButton1: () {
        //                 Navigator.pushReplacementNamed(
        //                   context,
        //                   PageName.loginView,
        //                 );
        //               },
        //               onTapButton2: () {
        //                 Navigator.pushReplacementNamed(
        //                   context,
        //                   PageName.continueSignUp,
        //                 );
        //               },
        //               title: TextManager.accountCreatedSuccessfully,
        //               subTitle: TextManager.accountCreatedSuccessfullyText,
        //               textOfButton1: TextManager.login,
        //               textOfButton2: TextManager.continueSignUp,
        //             ));
        //   } else {
        //     Navigator.pushNamed(context, PageName.resetPassword);
        //   }
        // } else if (state is VerifyOtpFailureState) {
        //   showSnakeBar(msg: state.message, snakeBarType: SnakeBarType.error);
        // }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is VerifyOtpLoadingState,
          enabled: cubit.otpController.text.length > 3,
          text: TextManager.verify,
          onPressed: () {
            cubit.verifyOtp(isRegisterFlow);
            Navigator.pushNamed(context, PageName.newPasswordScreen);
          },
        );
      },
    );
  }
}
