import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/circlular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          height: 50.h,
          color: ColorManager.darkGrey,
          child: Padding(
            padding: EdgeInsets.all(6.0.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                  child:const Icon(Icons.notifications,
                      color: ColorManager.primaryColor),
                ),
                horizontalSpace(10.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("App update Alert",
                            style: getBoldStyle(fontSize: 12.sp)),
                        horizontalSpace(7.sp),
                        Container(
                          height: 5.h,
                          width: 5.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                        horizontalSpace(7.sp),
                        Text("6h ago",
                            style: getMediumStyle(
                                fontSize: 12.sp,
                                color: ColorManager.lightGrey)),
                      ],
                    ),
                    Text(
                      "New features are there! Upadte car mate for..",
                      style: getRegularStyle(
                          fontSize: 12.sp, color: ColorManager.lightGrey),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
