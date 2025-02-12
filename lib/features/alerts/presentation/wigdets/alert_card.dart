import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: ColorManager.darkGrey,
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50.r)),
                  height: 20.sp,
                  width: 20.sp,
                  child: SvgPicture.asset(AssetsManager.warningIcon)),
            ],
          ),
          verticalSpace(2.sp),
          SizedBox(height: 70, width: 70, child: SvgPicture.asset(image)),
          verticalSpace(10.sp),
          Text(
            title,
            style: getMediumStyle(fontSize: 20.sp),
          ),
          verticalSpace(10.sp)
        ],
      ),
    );
  }
}
