import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';

class ResendComponent extends StatefulWidget {
  // final bool isRegisterFlow;
  const ResendComponent({super.key});

  @override
  State<ResendComponent> createState() => _ResendComponentState();
}

class _ResendComponentState extends State<ResendComponent> {
  late VerifyOtpCubit cubit;
  @override
  void initState() {
    cubit = VerifyOtpCubit.of(context);
    cubit.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    cubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (previous, current) => current is ResendOtpErrorState,
      listener: (context, state) {
        if (state is ResendOtpErrorState) {
          // showSnakeBar(msg: state.message, snakeBarType: SnakeBarType.error);
          kprint('ResendOtpErrorState');
        }
      },
      builder: (context, state) {
        var cubit = VerifyOtpCubit.of(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cubit.counter > 0) ...[
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${TextManager.resendAfter.tr()}\t",
                      style: getRegularStyle(
                        fontSize: 14,
                        color: context.secondaryColor,
                      ),
                    ),
                    TextSpan(
                      text: _formatCountdown(cubit.counter),
                      style: getMediumStyle(
                        fontSize: 14,
                        color: ColorManager.lightPrimaryColor,
                      ),
                    ),
                    TextSpan(
                      text: cubit.counter >= 60
                          ? '\t${TextManager.minutes.tr()}'
                          : '\t${TextManager.seconds.tr()}',
                      style: getRegularStyle(
                        fontSize: 14,
                        color: context.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // resend button
            if (cubit.counter == 0) ...[
              InkWell(
                onTap: () {
                  cubit.resendOtp();
                },
                child: CustomText(
                  text: TextManager.resend,
                  style: getMediumStyle(
                    fontSize: 16,
                    color: ColorManager.lightPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
            if (state is ResendOtpLoadingState) ...[
              const CircularProgressIndicator(),
            ]
          ],
        );
      },
    );
  }
}

String _formatCountdown(int seconds) {
  // convert seconds to minutes and remaining seconds
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;

  // return formatted string
  return '${minutes < 10 ? '0' : ''}$minutes:${remainingSeconds < 10 ? '0' : ''}$remainingSeconds';
}
