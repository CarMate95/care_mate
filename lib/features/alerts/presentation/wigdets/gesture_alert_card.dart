import 'package:car_mate/features/alerts/presentation/wigdets/alert_sign_card.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_sign_message.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GestureAlertCard extends StatelessWidget {
  const GestureAlertCard(
      {super.key,
      required this.title,
      required this.image,
      required this.alertTitle,
      required this.alertMessage});
  final String title;
  final Image image;
  final String alertTitle;
  final String alertMessage;
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
              return AlertMessage(alertText: alertMessage, title: alertTitle);
            },
          );
        },
        child: AlertSignCard(
          title: title,
          image: image,
        ),
      ),
    );
  }
}
