import 'dart:ui';

import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/color_manager.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: AlertDialog(
        title: Column(
          children: [
            Text(
              'Engine Light Alert',
              style: getMediumStyle(fontSize: 20.sp),
            ),
            const CustomDivider(
              color: ColorManager.primaryColor,
              thickness: 3,
            ),
          ],
        ),
        content: Text(
          'Check your car engine immediately to prevent further damage.',
          style: getBoldStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
