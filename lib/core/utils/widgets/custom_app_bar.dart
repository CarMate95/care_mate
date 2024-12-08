import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/color_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onBack,
    this.title,
    this.suffex,
    this.enbleBackIcon = true,
  });
  final void Function()? onBack;
  final String? title;
  final Widget? suffex;
  final bool enbleBackIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          if (enbleBackIcon) ...{
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
                size: 24.sp,
              ),
              onPressed: onBack ??
                  () {
                    Navigator.pop(context);
                  },
            ),
          },
          if (title != null) ...{
            const Spacer(),
            CustomText(
              text: title!,
              style: getBoldStyle(
                fontSize: 20,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              ),
            ),
          },
          const Spacer(),
          if (suffex != null) suffex!,
        ],
      ),
    );
  }
}
