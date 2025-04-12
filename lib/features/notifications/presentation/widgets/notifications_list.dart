import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/features/notifications/data/models/notification_model.dart';
import 'package:car_mate/features/notifications/data/repos/notification_repo.dart';
import 'package:car_mate/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationRepository notificationRepository =
        NotificationRepository();

    return FutureBuilder<List<NotificationModel>>(
      future: notificationRepository.getNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Failed to load notifications: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No notifications available'));
        }

        final notifications = snapshot.data!;

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0 || _isNewDay(notifications, index))
                  Text(
                    _getNotificationDate(notification.createdAt),
                    style: getBoldStyle(fontSize: 16.sp),
                  ),
                NotificationWidget(notification: notification),
                if (index < notifications.length - 1 &&
                    _isNewDay(notifications, index + 1))
                  Divider(
                    color: ColorManager.darkGrey,
                    thickness: 2.sp,
                  ),
              ],
            );
          },
        );
      },
    );
  }

  bool _isNewDay(List<NotificationModel> notifications, int index) {
    final current = notifications[index].createdAt.toLocal().day;
    final previous = notifications[index - 1].createdAt.toLocal().day;
    return current != previous;
  }

  String _getNotificationDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return TextManager.today.tr();
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return TextManager.yesterday.tr();
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }
}
