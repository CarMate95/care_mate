import 'package:car_mate/features/alerts/presentation/wigdets/alert_card.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_message.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GestureAlertCard extends StatelessWidget {
  const GestureAlertCard({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: () {
          showDialog<void>(
            context: context,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return const AlertMessage();
            },
          );
        },
        child: AlertCard(
          title: title,
          image: image,
        ),
      ),
    );
  }
}
