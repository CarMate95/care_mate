import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertHomeWidget extends StatelessWidget {
  const AlertHomeWidget(
      {super.key, required this.imageWidget, required this.title});
  final Widget imageWidget;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        child: Container(
          width: 150.w,
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          child: Row(
            children: [
              Padding(
                padding: context.locale.languageCode == 'en_US'
                    ? const EdgeInsets.only(
                        left: 15, top: 15, bottom: 15, right: 3)
                    : const EdgeInsets.only(
                        left: 4, top: 15, bottom: 15, right: 10),
                child: imageWidget,
              ),
              Text(
                title,
                style: getBoldStyle(fontSize: 12.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
