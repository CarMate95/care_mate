import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onBack,
    this.title,
    this.suffex,
    this.enbleBackIcon = true,
    this.color,
    this.closeIcon = false,
    this.isSettingsIcon = false,
  });
  final void Function()? onBack;
  final Widget? title;
  final Widget? suffex;
  final bool enbleBackIcon;
  final Color? color;
  final bool closeIcon;
  final bool isSettingsIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: EdgeInsets.only(top: 15.h, right: 10.h),
      child: Row(
        children: [
          if (enbleBackIcon) ...{
            isSettingsIcon
                ? InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, PageName.settingsScreen),
                    child: SvgPicture.asset(AssetsManager.settingIcon,
                        color: context.secondaryColor))
                : IconButton(
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
          if (title != null) ...{const Spacer(), title!},
          const Spacer(),
          if (suffex != null) suffex!,
        ],
      ),
    );
  }
}
