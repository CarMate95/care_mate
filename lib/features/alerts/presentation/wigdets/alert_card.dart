import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.title, required this.image});
  final String title;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace(10.sp),
          Row(
            children: [
              horizontalSpace(120.sp),
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: context.isDarkMode
                            ? ColorManager.black
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(50.r)),
                  height: 22.sp,
                  width: 22.sp,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      "i",
                      style: getSemiBoldStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
          verticalSpace(2.sp),
          SizedBox(height: 70, width: 70, child: image),
          verticalSpace(10.sp),
          Text(
            title,
            style:context.locale.languageCode == 'en_US' ? getSemiBoldStyle(fontSize: 20.sp) : getBoldStyle(fontSize: 20.sp),
          ),
          verticalSpace(10.sp)
        ],
      ),
    );
  }
}
