import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class CustomNewPassValidate extends StatelessWidget {
  const CustomNewPassValidate({
    super.key,
    required this.isValidate,
    required this.title,
  });
  final bool isValidate;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // x icon
          Icon(
            isValidate ? Icons.check_circle_outline : Icons.close,
            color: isValidate ? Colors.green : Colors.red,
          ),
          horizontalSpace(6),
          Flexible(
            child: CustomText(
              text: title,
              style: getMediumStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
