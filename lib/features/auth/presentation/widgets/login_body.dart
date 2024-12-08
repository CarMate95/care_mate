import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/color_manager.dart';
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
  bool enableValidation = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: enableValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace(100),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: TextManager.welcomeBack,
              style: getBoldStyle(
                fontSize: 36,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              ),
            ),
          ),
          verticalSpace(5),
          CustomText(
            text: TextManager.logInntoYourAccount,
            style: getSemiBoldStyle(
              fontSize: 16,
              color:
                  context.isDarkMode ? ColorManager.white : ColorManager.black,
            ),
          ),
          verticalSpace(24),
          // email
          EmailFeild(
            controller: emailController,
          ),
          verticalSpace(24),
          // password
          PasswordFeild(
            labelText: TextManager.password,
            controller: passwordController,
          ),
          verticalSpace(8),
          // remember me and forget password row
          const RememberMeAndForgetPasswordRow(),
          verticalSpace(24),
          // login button
          CustomElevatedButton(
            onPressed: () {
              setState(() {
                enableValidation = true;
              });

              // to validate the form
              if (!formKey.currentState!.validate()) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                PageName.layoutScreen,
                (route) => false,
              );
            },
            text: TextManager.login,
          ),
          verticalSpace(8),
          // need an account? sign up
          CustomAccountHintRow(
            text: TextManager.needAnAccount,
            buttonText: TextManager.signUp,
            onPressed: () {
              // navigate to sign up screen
              Navigator.pushNamed(context, PageName.signUpScreen);
            },
          ),
        ],
      ),
    );
  }
}
