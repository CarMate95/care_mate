import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({
    super.key,
    required this.text,
    required this.isIcon,
  });

  final String text;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(16.r),
        bottomStart: Radius.circular(16.r),
      ),
      child: Container(
        height: 73.h,
        width: 175.w,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isIcon)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Image.asset(
                    AssetsManager.editPenPng,
                    height: 24.h,
                    width: 24.h,
                    fit: BoxFit.contain,
                  ),
                ),
              Expanded(
                child: Text(
                  text,
                  style: getLightStyle(fontSize: 16.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
