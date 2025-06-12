import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSignCard extends StatelessWidget {
  const AlertSignCard({super.key, required this.title, required this.image});
  final String title;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 200.w,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        context.isDarkMode ? ColorManager.black : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(50.r),
                ),
                height: 22.sp,
                width: 22.sp,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    "i",
                    style: getSemiBoldStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(5.sp),
          SizedBox(height: 70.h, width: 70.w, child: image),
          SizedBox(height: 1.sp),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.locale.languageCode == 'en_US'
                  ? getSemiBoldStyle(fontSize: 18.sp)
                  : getBoldStyle(fontSize: 18.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
