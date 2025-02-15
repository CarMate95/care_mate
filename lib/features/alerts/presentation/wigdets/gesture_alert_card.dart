import 'package:car_mate/features/alerts/presentation/wigdets/alert_card.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_message.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GestureAlertCard extends StatelessWidget {
  final String title;
  final Image image;
  final String alertMessage;
  final String alertTitle;

  const GestureAlertCard({
    required this.title,
    required this.image,
    required this.alertMessage,
    required this.alertTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: image, 
          ),
          SizedBox(height: 8), 
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp, 
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2, 
            overflow: TextOverflow.ellipsis, 
          ),
        ],
      ),
    );
  }
}
