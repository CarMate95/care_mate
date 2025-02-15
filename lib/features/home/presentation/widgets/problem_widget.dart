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
import 'package:flutter_svg/flutter_svg.dart';

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      child: Container(
        height: 63.h,
        width: double.infinity,
        color: context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  TextManager.shareYourCarProblem.tr(),
                  style: getMediumStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, PageName.createPostScreen);
                },
                icon: SvgPicture.asset(AssetsManager.galleryIcon),
                iconSize: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
