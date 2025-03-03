import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/di/di.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/verify_otp/verify_otp_cubit.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/resend_component.dart';
import '../widgets/verify_otp_button.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyOtpCubit>(
          create: (context) => VerifyOtpCubit.of(context),
        ),
        BlocProvider.value(
          value: sl.get<AuthCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return CustomScaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(),
                verticalSpace(40),
                const CustomSvgIcon(
                  iconPath: AssetsManager.emailImage,
                  size: 170,
                ),
                verticalSpace(24),
                CustomText(
                  text: TextManager.verifyYourEmailAddress,
                  style: getBoldStyle(
                    fontSize: 22,
                    color: context.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(8),
                CustomText(
                  text: TextManager.verifyWithTheCode,
                  style: getRegularStyle(
                    fontSize: 16,
                    color: context.secondaryColor.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(24), // OTP Input
                OtpInputField(
                  otpController: authCubit.otpController,
                  onChanged: AuthCubit.get(context).onChangeOtp(),
                ),

                verticalSpace(16),

                // Resend Component
                const ResendComponent(),
                verticalSpace(33),

                // Verify OTP Button
                const VerifyOtpButton(isRegisterFlow: true),
              ],
            ),
          ),
        );
      }),
    );
  }
}
