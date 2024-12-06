import 'package:car_mate/config/themes/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/utils/widgets/custom_svg_icon.dart';

GButton customNavBarItem({required String text, required String iconPath}) {
  return GButton(
    borderRadius: BorderRadius.circular(16.r),
    icon: Icons.home,
    text: text.tr(),
    textStyle: getSemiBoldStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    backgroundColor: Colors.black,
    leading: CustomSvgIcon(
      iconPath: iconPath,
      color: Colors.white,
      size: 24,
    ),
  );
}
