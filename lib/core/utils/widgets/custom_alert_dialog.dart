import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/config/themes/text_style.dart';

void showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  double? horizontalPadding,
  double? verticalPadding,
  double? intensHorizontalPadding,
  bool isdecoration = true,
  bool isAlignCenter = false,
}) {
  showDialog(
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: intensHorizontalPadding?.w ?? 12.w,
        ),
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: CustomText(
            textAlign: isAlignCenter ? TextAlign.center : null,
            text: title,
            style: getBoldStyle(
                fontSize: 20,
                decoration: isdecoration ? TextDecoration.underline : null),
          ),
        ),
        content: SingleChildScrollView(child: content),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding?.w ?? 10.w,
          vertical: verticalPadding?.h ?? 20.h,
        ),
      );
    },
    context: context,
  );
}
