import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/text_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class CustomAccountHintRow extends StatelessWidget {
  const CustomAccountHintRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: TextManager.needAnAccount,
          style: getMediumStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        horizontalSpace(4),
        InkWell(
          onTap: () {},
          child: CustomText(
            text: TextManager.signUp,
            style: getMediumStyle(
              fontSize: 12,
              color: ColorManager.lightPrimaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
