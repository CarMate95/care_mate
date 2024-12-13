import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCreatePostWidget extends StatelessWidget {
  const CustomCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
      child: TextField(
        cursorColor: context.isDarkMode ? ColorManager.white : Colors.black,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetsManager.picturePostIcon,
              color: context.isDarkMode ? ColorManager.lightGrey : Colors.black,
            ),
          ),
          border: InputBorder.none,
          hintText: TextManager.whatHappening.tr(),
          hintStyle: getLightStyle(
            color: context.isDarkMode ? ColorManager.lightGrey : Colors.black,
          ),
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: const CustomCircularAvatar(),
        ),
      ),
    );
  }
}
