import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 184.h,
        width: 168.w,
        color: context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Column(
          children: [
            verticalSpace(10.h),
            Row(
              children: [
                horizontalSpace(10.sp),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                   TextManager.donForgetTo.tr(),
                    style: getBoldStyle(fontSize: 16.sp),
                  ),
                  Text(
                    TextManager.changeFuel.tr(),
                    style: getBoldStyle(fontSize: 16.sp),
                  ),
                ]),
                horizontalSpace(5.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    color: ColorManager.black,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        AssetsManager.notificationIcon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(10.sp),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(TextManager.start.tr(), style: getBoldStyle(fontSize: 16.sp)),
                  Text(
                    " ...",
                    style: getBoldStyle(fontSize: 30.sp)
                        .copyWith(color: Colors.blue),
                  ),
                  Text(TextManager.startTime.tr(), style: getBoldStyle(fontSize: 12.sp)),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(TextManager.end.tr(), style: getBoldStyle(fontSize: 16.sp)),
                  Text(
                    " ...",
                    style: getBoldStyle(fontSize: 30.sp)
                        .copyWith(color: Colors.red),
                  ),
                  Text(TextManager.endTime.tr(), style: getBoldStyle(fontSize: 12.sp)),
                ]),
          
          ],
        ),
      ),
    );
  }
}
