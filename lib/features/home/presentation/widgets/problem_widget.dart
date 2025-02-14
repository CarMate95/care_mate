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

class ProblemWidget extends StatelessWidget {
  const ProblemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
      child: Container(
        height: 63.h,
        width: 200.w,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Row(
          children: [
            horizontalSpace(20.sp),
            Text(
              TextManager.shareYourCarProblem.tr(),
              style: getMediumStyle(),
            ),
            horizontalSpace(80.sp),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AssetsManager.galleryIcon))
          ],
        ),
      ),
    );
  }
}
