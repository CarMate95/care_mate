import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/chat/presentation/widgets/animated_selectable_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/text_manager.dart';
import '../widgets/custom_ai_intro_card.dart';

class IntroAiScreen extends StatelessWidget {
  const IntroAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            CustomText(
              text: '${TextManager.hello.tr()} 🤖',
              style: getBoldStyle(
                fontSize: 36,
                color: context.secondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSelectableText(
              fullText: TextManager.howCanIAssistYouRightNow.tr(),
              textStyle: getSemiBoldStyle(
                color: context.secondaryColor,
                fontSize: 28,
              ),
              animationDuration: const Duration(milliseconds: 70),
            ),
            SizedBox(height: 24.h),

            // Cards
            SizedBox(
              height: 0.2.sh,
              child: CustomAiIntroCard(
                backgroundColor: ColorManager.primaryColor,
                text: TextManager.useAIToAnalyzeComplexCarProblems,
                icon: Icons.build_circle,
                textColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, PageName.chatScreen);
                },
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 0.3.sh,
              child: Row(
                children: [
                  Flexible(
                    child: CustomAiIntroCard(
                      backgroundColor: ColorManager.lightPrimaryColor,
                      text: TextManager.estimateYourCarsValue,
                      // dollar sign icon
                      icon: Icons.attach_money,
                      onTap: () {
                        Navigator.pushNamed(context, PageName.carPriceScreen);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Flexible(
                    child: CustomAiIntroCard(
                      backgroundColor: ColorManager.secondaryColor2,
                      text: TextManager.aIDrivenCarHealthCheck,
                      icon: Icons.monitor_heart_outlined,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: TextManager.noteAIin.tr(),
                      style: getBoldStyle(
                        color: context.secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: TextManager.beta.tr(),
                      style: getBoldStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: TextManager.answersMayNotBeFully.tr(),
                      style: getBoldStyle(
                        color: context.secondaryColor,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: TextManager.accurate.tr(),
                      style: getBoldStyle(
                        color: ColorManager.primaryColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
