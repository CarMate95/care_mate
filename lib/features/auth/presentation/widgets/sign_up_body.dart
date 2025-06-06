import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:car_mate/core/utils/widgets/email_field.dart';
import 'package:car_mate/core/utils/widgets/password_field.dart';
import 'package:car_mate/features/auth/data/models/user_data.dart';
import 'package:car_mate/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/enums/user_type.dart';
import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_text.dart';
import '../../../../core/utils/widgets/location_field.dart';
import '../../../../core/utils/widgets/phone_field.dart';
import 'custom_account_hint_row.dart';
import 'custom_role.dart';
import 'custom_specialization.dart';
import 'first_name_and_last_name.dart';
import 'sign_up_button.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  UserRole? userRoleValue;
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool startValidation = false;
  String? specializationValue;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    locationController.dispose();
    phoneController.dispose();
    formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: startValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          // // custom app bar
          // CustomAppBar(
          //   suffex: Row(
          //     children: [
          //       // change language
          //       IconButton(
          //         onPressed: () {
          //           context.changeLanguage();
          //         },
          //         icon: const Icon(Icons.language),
          //       ),
          //       horizontalSpace(10),
          //       // change theme
          //       IconButton(
          //         onPressed: () {
          //           context.changeTheme();
          //         },
          //         icon: const Icon(Icons.brightness_4),
          //       )
          //     ],
          //   ),
          // ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: TextManager.createYourAccount,
              style: getBoldStyle(
                fontSize: 36,
                color: context.secondaryColor,
              ),
            ),
          ),
          verticalSpace(5),
          CustomText(
            text: TextManager.letsGetYouStarted,
            style: getSemiBoldStyle(
              fontSize: 16.sp,
              // ignore: deprecated_member_use
              color: context.secondaryColor.withOpacity(0.8),
            ),
          ),
          verticalSpace(24),
          // first name and last name
          FirstNameAndLastName(
            firstNameController: firstNameController,
            lastNameController: lastNameController,
          ),
          verticalSpace(24),
          // email
          EmailField(
            controller: emailController,
          ),
          verticalSpace(24),
          // password
          PasswordField(
            labelText: TextManager.password,
            controller: passwordController,
          ),
          verticalSpace(24),
          // confirm password
          PasswordField(
            labelText: TextManager.confirmPassword,
            controller: confirmPasswordController,
          ),
          verticalSpace(24),

          CustomRole(
            onSelectedType: (userRole) {
              setState(() {
                userRoleValue = userRole;
              });
            },
          ),
          // if user type is not selected
          if (userRoleValue == null && startValidation) ...{
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomText(
                text: TextManager.selectYourRoleToContinue,
                style: getRegularStyle(
                  fontSize: 11,
                  color: Colors.red,
                ),
                textAlign: TextAlign.end,
              ),
            )
          },
          verticalSpace(12),

          // if user type is mechanic
          if (userRoleValue == UserRole.worker) ...{
            // specialization
            CustomSpecialization(
              onChanged: (value) {
                setState(() {
                  specializationValue = value;
                });
                kprint('specialization value: $specializationValue');
              },
            ),
            verticalSpace(12),
            // location feild
            LocationField(
              controller: locationController,
            ),
            verticalSpace(12),
            // phone number
            PhoneField(
              controller: phoneController,
            ),
            verticalSpace(24),
          },

          // sign up button
          SignUpButton(
            onPressed: () async {
              setState(() {
                startValidation = true;
              });
              if (!formKey.currentState!.validate()) return;
              await AuthCubit.get(context).signup(
                user: UserData(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                  role: userRoleValue!,
                  specialization: specializationValue,
                  location: locationController.text.isEmpty
                      ? null
                      : locationController.text,
                  phoneNumber: phoneController.text.isEmpty
                      ? null
                      : phoneController.text,
                  // specialization:
                ),
              );
            },
          ),

          verticalSpace(8),
          // already have an account? login
          CustomAccountHintRow(
            text: TextManager.alreadyHaveAnAccount,
            buttonText: TextManager.login,
            onPressed: () {
              // navigate to login screen
              Navigator.pop(context);
            },
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
