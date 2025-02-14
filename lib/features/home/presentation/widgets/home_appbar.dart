import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

AppBar homeAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        TextManager.rawanAyman.tr(),
        style: getBoldStyle(fontSize: 16.sp),
      ),
      verticalSpace(2.sp),
      Text(
        TextManager.welcomeBack.tr(),
        style: getBoldStyle(fontSize: 12.sp),
      )
    ]),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 40.h,
              width: 40.w,
              color: ColorManager.lightGrey,
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageName.notificationScreen);
                  },
                  child: SvgPicture.asset(
                    AssetsManager.notificationIcon,
                  ),
                ),
              ),
            ),
          ),
          horizontalSpace(8.sp),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              height: 40.h,
              width: 40.w,
              color: ColorManager.lightGrey,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageName.settingsScreen);
                  },
                  child: Image.asset(AssetsManager.settingPicturePng)),
            ),
          ),
        ]),
      ),
    ],
    leading: Container(
      height: 50.h,
      width: 50.w,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageName.accountdetailsScreen);
                },
                child: Image.asset("assets/images/profile_image.jpg"))),
      ),
    ),
  );
}
