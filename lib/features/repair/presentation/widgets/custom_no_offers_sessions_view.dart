import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomNoDataYet extends StatelessWidget {
  const CustomNoDataYet({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(30),
        Center(
          child: SvgPicture.asset(
            imageUrl,
            width: 292.w,
            height: 237.h,
            fit: BoxFit.cover,
          ),
        ),
        verticalSpace(30),
        CustomText(
          text: title,
          style: getBoldStyle(
            fontSize: 24.sp,
            color: context.secondaryColor,
          ),
        ),
        verticalSpace(10),
        CustomText(
          textAlign: TextAlign.center,
          text: description,
          style: getMediumStyle(
            color: context.secondaryColor,
          ),
        ),
      ],
    );
  }
}
