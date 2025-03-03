import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar homeAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        GestureDetector(
        onTap: () => Navigator.pushNamed(context, PageName.accountdetailsScreen),
          child: Text(
            TextManager.rawanAyman.tr(),
            style: getBoldStyle(fontSize: 16.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        verticalSpace(2.sp),
        Text(
          TextManager.welcomeBack.tr(),
          style: getBoldStyle(fontSize: 12.sp),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _iconButton(
              context,
              icon: SvgPicture.asset(AssetsManager.notificationIcon),
              onTap: () => Navigator.pushNamed(context, PageName.notificationScreen),
            ),
            horizontalSpace(8.sp),
            _iconButton(
              context,
              icon: Image.asset(AssetsManager.settingPicturePng),
              onTap: () => Navigator.pushNamed(context, PageName.settingsScreen),
            ),
          ],
        ),
      ),
    ],
    leading: Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, PageName.accountdetailsScreen),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            "assets/images/profile_image.jpg",
            height: 50.h,
            width: 50.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

Widget _iconButton(BuildContext context, {required Widget icon, required VoidCallback onTap}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.r),
    child: Container(
      height: 40.h,
      width: 40.w,
      color: ColorManager.lightGrey,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: icon,
        ),
      ),
    ),
  );
}
