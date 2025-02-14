import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          TextManager.today.tr(),
          style: getBoldStyle(fontSize: 16.sp),
        ),
        const NotificationWidget(),
        const NotificationWidget(),
        const NotificationWidget(),
        Divider(
          color: ColorManager.darkGrey,
          thickness: 2.sp,
        ),
        Text(
          TextManager.yesterday.tr(),
          style: getBoldStyle(fontSize: 16.sp),
        ),
        const NotificationWidget(),
        const NotificationWidget(),
        const NotificationWidget(),
        Divider(
          color: ColorManager.darkGrey,
          thickness: 2.sp,
        ),
        Text(
          TextManager.lastDays.tr(),
          style: getBoldStyle(fontSize: 16.sp),
        ),
        const NotificationWidget(),
        const NotificationWidget(),
        const NotificationWidget(),
        const NotificationWidget(),
        const NotificationWidget(),
      ],
    );
  }
}
