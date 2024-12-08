import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class CustomAccountHintRow extends StatelessWidget {
  const CustomAccountHintRow({
    super.key,
    required this.text,
    required this.buttonText,
    this.onPressed,
  });
  final String text;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: text,
          style: getMediumStyle(
            fontSize: 12,
            color: context.isDarkMode ? ColorManager.white : ColorManager.black,
          ),
        ),
        horizontalSpace(4),
        // sign up button
        InkWell(
          onTap: onPressed,
          child: CustomText(
            text: buttonText,
            style: getMediumStyle(
              fontSize: 12,
              color: context.isDarkMode
                  ? ColorManager.lightPrimaryColor
                  : ColorManager.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
