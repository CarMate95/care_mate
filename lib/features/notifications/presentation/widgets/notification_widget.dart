import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          height: 50.h,
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          child: Padding(
            padding: EdgeInsets.all(6.0.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.notifications,
                      color: ColorManager.primaryColor),
                ),
                horizontalSpace(10.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(TextManager.appUpdateAlert.tr(),
                            style: getBoldStyle(fontSize: 12.sp)),
                        horizontalSpace(7.sp),
                        Container(
                          height: 5.h,
                          width: 5.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                        horizontalSpace(7.sp),
                        Text(TextManager.hAgo.tr(),
                            style: getMediumStyle(
                              fontSize: 12.sp,
                              color: context.isDarkMode
                                  ? ColorManager.lightGrey
                                  : ColorManager.darkGrey,
                            )),
                      ],
                    ),
                    Text(
                      TextManager.newFeatures.tr(),
                      style: getRegularStyle(
                        fontSize: 12.sp,
                        color: context.isDarkMode
                            ? ColorManager.lightGrey
                            : ColorManager.darkGrey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
