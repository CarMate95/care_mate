import 'package:flutter/material.dart';

import '../../../../config/themes/text_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../../../../core/utils/widgets/email_feild.dart';
import '../../../../core/utils/widgets/password_feild.dart';
import 'custom_account_hint_row.dart';
import 'remember_me_and_forget_password_row.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace(100),
          CustomText(
            text: TextManager.welcomeBack,
            style: getBoldStyle(fontSize: 40, color: Colors.white),
          ),
          verticalSpace(5),
          CustomText(
            text: TextManager.logInntoYourAccount,
            style: getSemiBoldStyle(fontSize: 16, color: Colors.white),
          ),
          verticalSpace(28),
          EmailFeild(
            controller: emailController,
          ),
          verticalSpace(24),
          PasswordFeild(
            hintText: TextManager.password,
            controller: passwordController,
          ),
          verticalSpace(8),
          const RememberMeAndForgetPasswordRow(),
          verticalSpace(24),
          CustomElevatedButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
            },
            text: TextManager.login,
          ),
          verticalSpace(8),
          const CustomAccountHintRow(),
        ],
      ),
    );
  }
}
