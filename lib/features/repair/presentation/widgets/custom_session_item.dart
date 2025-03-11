import 'dart:ui';

import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_build_confirmation_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/core/utils/widgets/custom_rating.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/profile/widgets/profile_service.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSessionItem extends StatelessWidget {
  const CustomSessionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomAlertDialog(
            context: context,
            title: 'Problem Details',
            content: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 100.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.tertiaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const CustomCircularAvatar(
                          backgroundColor: ColorManager.lightPrimaryColor,
                        ),
                        horizontalSpace(8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Omar Elmasry',
                              style: getMediumStyle(
                                color: context.secondaryColor,
                              ),
                            ),
                            CustomText(
                              text: '@11Elmasryyyy',
                              style: getMediumStyle(
                                color: context.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: CustomElevatedButton(
                              height: 40.h,
                              size: 14,
                              textColor: ColorManager.white,
                              backgroundColor: ColorManager.blue,
                              onPressed: () {},
                              text: 'Worker Details',
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(16),
                    CustomDivider(color: context.secondaryColor),
                    verticalSpace(9),
                    CustomText(
                      text: 'Your Problem:',
                      style: getMediumStyle(
                        color: context.secondaryColor,
                      ),
                    ),
                    verticalSpace(5),
                    CustomText(
                      text:
                          ''' "Hey everyone! I need some advice with my car. It’s been giving me trouble, and I’m not sure what’s wrong.
          Here’s what’s happening:
          
          Noise: There’s a weird rattling sound coming from the engine area, especially when I start it up or drive at lower speeds.
          Performance: It feels a bit sluggish, like it’s struggli ''',
                      style: getRegularStyle(
                          fontSize: 12, color: context.secondaryColor),
                    ),
                    verticalSpace(5),
                    CustomElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: context.scaffoldBackgroundColor,
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                // child: _buildDeleteConfirmationDialog(context),
                              );
                            },
                          );
                        },
                        text: 'End Session '),
                  ],
                ),
              ),
            ));
      },
      child: Container(
        width: double.infinity,
        height: 298.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.tertiaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomCircularAvatar(
                    backgroundColor: ColorManager.lightPrimaryColor,
                  ),
                  horizontalSpace(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Omar Elmasry',
                        style: getMediumStyle(
                          color: context.secondaryColor,
                        ),
                      ),
                      CustomText(
                        text: '@11Elmasryyyy',
                        style: getMediumStyle(
                          color: context.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: CustomElevatedButton(
                        height: 40.h,
                        width: 118.w,
                        size: 14,
                        textColor: ColorManager.white,
                        backgroundColor: ColorManager.blue,
                        onPressed: () {},
                        text: 'Worker Details',
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              CustomDivider(color: context.secondaryColor),
              verticalSpace(9),
              CustomText(
                text: 'Your Problem:',
                style: getMediumStyle(
                  color: context.secondaryColor,
                ),
              ),
              verticalSpace(5),
              const Spacer(),
              CustomText(
                lines: 7,
                text:
                    ''' "Hey everyone! I need some advice with my car. It’s been giving me trouble, and I’m not sure what’s wrong.
            Here’s what’s happening:
            
            Noise: There’s a weird rattling sound coming from the engine area, especially when I start it up or drive at lower speeds.
            Performance: It feels a bit sluggish, like it’s struggli ''',
                style: getRegularStyle(
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              verticalSpace(5),
              CustomElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: context.scaffoldBackgroundColor,
                    builder: (BuildContext context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: customBuildConfirmationDialog(
                          context: context,
                          btnText: 'End Session',
                          description:
                              'Are You Sure that you want to End this Session .',
                          onPressed: () {
                            showCustomAlertDialog(
                              context: context,
                              isdecoration: false,
                              isAlignCenter: true,
                              title: 'How Do You Rate Our Workers Service?',
                              content: Column(
                                children: [
                                  const CustomRating(),
                                  verticalSpace(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Bad',
                                        style: getRegularStyle(),
                                      ),
                                      CustomText(
                                        text: 'Excellent',
                                        style: getRegularStyle(),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                text: 'End Session ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
