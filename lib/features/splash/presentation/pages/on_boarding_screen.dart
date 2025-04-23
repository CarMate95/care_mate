import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250.h,
            width: double.infinity,
            child: Image.asset(
              AssetsManager.carOB,
              fit: BoxFit.cover,
              // color: context.primaryColor,
            ),
          ),
          verticalSpace(20.h),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: TextManager.welcomeTo.tr(),
                  style: getBoldStyle(
                    fontSize: 32,
                    color: context.secondaryColor,
                  ),
                ),
                TextSpan(
                  text: " Car",
                  style: getBoldStyle(
                    fontSize: 32,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: "Mate",
                  style: getBoldStyle(
                    fontSize: 32,
                    color: context.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: TextManager.use.tr(),
                  style:
                      getBoldStyle(fontSize: 16, color: context.secondaryColor),
                ),
                TextSpan(
                  text: " ${TextManager.ai.tr()} ",
                  style: getBoldStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                TextSpan(
                  text: TextManager.toDiagnose.tr(),
                  style: getBoldStyle(
                    fontSize: 16,
                    color: context.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(60),
          CustomElevatedButton(
            width: 200.w,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PageName.loginScreen,
                (route) => false,
              );
            },
            text: TextManager.getStarted,
            borderRadius: 26,
            backgroundColor: context.isDarkMode ? Colors.white : Colors.red,
            textColor: context.isDarkMode ? Colors.black : Colors.white,
          ),
        ],
      ),
    );
  }
}
