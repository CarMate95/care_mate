import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomRowAccountDetails extends StatelessWidget {
  const CustomRowAccountDetails(
      {super.key, required this.text, required this.icon, this.iconColor});
  final String text;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorManager.grey)),
          child: Icon(icon, color: iconColor),
        ),
        horizontalSpace(10),
        CustomText(
          text: text,
          style: getMediumStyle(color: context.secondaryColor),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios, color: context.secondaryColor),
      ],
    );
  }
}
