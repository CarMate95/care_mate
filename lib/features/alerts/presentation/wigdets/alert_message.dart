import 'dart:ui';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/color_manager.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key, required this.title, required this.alertText});
  final String title;
  final String alertText;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: AlertDialog(
        title: Column(
          children: [
            Text(
              title,
              style: getMediumStyle(fontSize: 20.sp),
              overflow: TextOverflow.visible,
            ),
            const CustomDivider(
              color: ColorManager.primaryColor,
              thickness: 3,
            ),
          ],
        ),
        content: Text(
          alertText,
          style: getBoldStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
