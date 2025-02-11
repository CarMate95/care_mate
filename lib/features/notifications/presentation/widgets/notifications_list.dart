import 'package:car_mate/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => const NotificationWidget(),);
  }
}