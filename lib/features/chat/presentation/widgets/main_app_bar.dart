import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, this.isChatbotScreen = false});
  final bool isChatbotScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24.r,
              color: context.secondaryColor,
            ),
          ),
          if (isChatbotScreen) ...{
            const Spacer(),
            const CustomSvgIcon(
              iconPath: AssetsManager.robotIcon,
              color: ColorManager.primaryColor,
            ),
          },
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageName.settingsScreen);
            },
            child: CustomSvgIcon(
              iconPath: AssetsManager.settingIcon,
              size: 24.r,
              color: context.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
