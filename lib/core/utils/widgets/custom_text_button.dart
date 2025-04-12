import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/Material.dart';

import '../../../config/themes/text_style.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function()? ontap;
  final double? fontSize;
  final bool enabled;
  final Color? underlineColor;

  const CustomTextButton({
    super.key,
    required this.title,
    this.color,
    this.ontap,
    this.underlineColor,
    this.enabled = true,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
      ),
      onPressed: ontap,
      child: CustomText(
        text: title,
        style: getBoldStyle(
          color:
              enabled ? color ?? context.primaryColor : context.secondaryColor,
          fontSize: fontSize ?? 15,
        ).copyWith(
          decoration: underlineColor != null && enabled
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: underlineColor,
        ),
      ),
    );
  }
}
