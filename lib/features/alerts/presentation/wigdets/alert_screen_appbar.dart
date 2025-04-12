import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar alertScreenAppBar(BuildContext context) {
  return AppBar(
    title: ClipRRect(
      borderRadius: BorderRadius.circular(20.sp),
      child: Container(
        height: 37.h,
        width: 170.w,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Row(children: [
          Container(
            height: 33.h,
            width: 88.w,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 0.2.sp,
                ),
                borderRadius: BorderRadius.circular(20.sp)),
            child: Center(
                child: Text(TextManager.alerts.tr(),
                    style: getRegularStyle(fontSize: 16.sp))),
          ),
          horizontalSpace(10.sp),
          Text(TextManager.signs.tr(),
              style: getRegularStyle(
                fontSize: 16.sp,
                color: ColorManager.grey,
              ))
        ]),
      ),
    ),
    centerTitle: true,
    leading: Container(),
  );
}
