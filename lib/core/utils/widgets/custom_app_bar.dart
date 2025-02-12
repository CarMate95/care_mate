import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onBack,
    this.title,
    this.suffex,
    this.enbleBackIcon = true,
    this.color,
    this.closeIcon = false,
  });
  final void Function()? onBack;
  final String? title;
  final Widget? suffex;
  final bool enbleBackIcon;
  final Color? color;
  final bool closeIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.only(top: 15.h, right: 10.h),
      child: Row(
        children: [
          if (enbleBackIcon) ...{
            IconButton(
              icon: Icon(
                closeIcon ? Icons.close : Icons.arrow_back_ios,
                color: context.secondaryColor,
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
                fontSize: 20.sp,
                color: context.secondaryColor,
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
