import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/helpers/time_formate.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/notifications/data/models/notification_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          child: Padding(
            padding: EdgeInsets.all(6.0.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(notification.profilePicture)),
                ),
                horizontalSpace(10.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.firstName +
                                  " " +
                                  notification.lastName,
                              style: getBoldStyle(fontSize: 12.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          horizontalSpace(7.sp),
                          Text(
                            notification.type,
                            style: getBoldStyle(fontSize: 12.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          horizontalSpace(10.sp),
                          if (!notification.isRead)
                            Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                          horizontalSpace(7.sp),
                          Text(
                            timeAgo(notification.createdAt),
                            style: getMediumStyle(
                              fontSize: 12.sp,
                              color: context.isDarkMode
                                  ? ColorManager.lightGrey
                                  : ColorManager.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.sp),
                      Flexible(
                        child: Text(
                          context.locale.languageCode == 'ar'
                              ? notification.arabicMessage
                              : notification.message,
                          style: getRegularStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? ColorManager.lightGrey
                                : ColorManager.darkGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
