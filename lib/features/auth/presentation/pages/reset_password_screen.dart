import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/email_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_text.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  bool startValidation = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    fromKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                text: TextManager.resetPassword,
                style: getMediumStyle(
                  fontSize: 22,
                  color: context.secondaryColor,
                ),
              ),
              verticalSpace(16),
              CustomText(
                text: TextManager.resetPasswordSubtitle,
                style: getMediumStyle(
                  fontSize: 16,
                  color: context.secondaryColor.withOpacity(0.8),
                ),
              ),
              verticalSpace(32),
              // email
              EmailField(
                controller: _emailController,
              ),
              verticalSpace(24),
              // send code button
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    startValidation = true;
                  });
                  if (!fromKey.currentState!.validate()) return;
                },
                text: TextManager.sendCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
