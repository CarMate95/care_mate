import 'package:car_mate/config/routes/page_name.dart';
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
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, PageName.notedetailsscreen);
        },
        child: Container(
          height: 170.h,
          width: 155.w,
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextManager.donForgetTo.tr(),
                          style: getBoldStyle(fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          TextManager.changeFuel.tr(),
                          style: getBoldStyle(fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 35.h,
                      width: 35.w,
                      color: ColorManager.black,
                      child: Padding(
                        padding: EdgeInsets.all(6.sp),
                        child: SvgPicture.asset(
                          AssetsManager.notificationIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(15.h),
              _buildReminderRow(TextManager.start.tr(), Colors.blue,
                  TextManager.startTime.tr()),
              verticalSpace(5.h),
              _buildReminderRow(
                  TextManager.end.tr(), Colors.red, TextManager.endTime.tr()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReminderRow(String label, Color dotColor, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: getBoldStyle(fontSize: 14.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            "...",
            style: getBoldStyle(fontSize: 25.sp).copyWith(color: dotColor),
          ),
        ),
        Expanded(
          child: Text(
            time,
            style: getBoldStyle(fontSize: 12.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
