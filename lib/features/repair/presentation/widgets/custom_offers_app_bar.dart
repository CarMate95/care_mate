import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOffersAppBar extends StatelessWidget {
  const CustomOffersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: CustomText(
        text: TextManager.offer.tr(),
        style: getSemiBoldStyle(
          fontSize: 24.sp,
          color: context.secondaryColor,
        ),
      ),
      suffex: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, PageName.sessionScreen);
        },
        icon: Icon(
          Icons.timer,
          color: context.secondaryColor,
          size: 28,
        ),
      ),
    );
  }
}
