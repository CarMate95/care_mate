import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:car_mate/features/auth/presentation/widgets/validation_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/custom_text.dart';
import '../../../../core/utils/widgets/password_field.dart';
import '../cubit/password_validation/password_validation_cubit.dart';
import '../widgets/change_password_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  bool startValidation = false;

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fromKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordValidationCubit>(
          create: (context) => PasswordValidationCubit(),
        ),
        BlocProvider.value(
          value: AuthCubit.get(context),
        ),
      ],
      child: Builder(builder: (context) {
        return CustomScaffold(
          body: SingleChildScrollView(
            child: Form(
              key: fromKey,
              autovalidateMode: startValidation
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  verticalSpace(16),
                  CustomText(
                    text: TextManager.createNewPassword,
                    style: getMediumStyle(
                      fontSize: 22,
                      color: context.secondaryColor,
                    ),
                  ),
                  verticalSpace(16),
                  CustomText(
                    text: TextManager.createNewPasswordText,
                    style: getMediumStyle(
                      fontSize: 16,
                      // ignore: deprecated_member_use
                      color: context.secondaryColor.withOpacity(0.8),
                    ),
                  ),
                  verticalSpace(32),
                  // password
                  PasswordField(
                    labelText: TextManager.password,
                    controller: passwordController,
                    onchangeFun: (value) {
                      PasswordValidationCubit.get(context)
                          .validatePassword(value!);
                    },
                  ),
                  verticalSpace(24),
                  // confirm password
                  PasswordField(
                    labelText: TextManager.confirmPassword,
                    controller: confirmPasswordController,
                  ),
                  verticalSpace(24),
                  // validation form
                  const ValidationForm(),
                  verticalSpace(24),
                  // reset password button
                  ChangePasswordButton(
                    onPressed: () async {
                      setState(() {
                        startValidation = true;
                      });
                      // if (!fromKey.currentState!.validate()) return;
                      if (passwordController.text ==
                              confirmPasswordController.text &&
                          PasswordValidationCubit.get(context).isValidate) {
                        await AuthCubit.get(context).changePassword(
                            newPassword: passwordController.text);
                      } else {
                        showScaffoldMessage(
                          context,
                          message: "Password not matched",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
