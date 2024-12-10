import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../core/utils/widgets/custom_svg_icon.dart';

GButton customNavBarItem({
  required String text,
  required String iconPath,
  required BuildContext context,
}) {
  return GButton(
    borderRadius: BorderRadius.circular(16.r),
    icon: Icons.home,
    text: text.tr(),
    textStyle: getSemiBoldStyle(
      color: context.secondaryColor,
      fontSize: 16,
    ),
    backgroundColor: //TODO: check colors
        context.isDarkMode ? ColorManager.black : ColorManager.grey,
    leading: CustomSvgIcon(
      iconPath: iconPath,
      color: context.secondaryColor,
      size: 24,
    ),
    active: false,
  );
}
