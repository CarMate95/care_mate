import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/config/themes/text_style.dart';

/// Any string value should passed to here
class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int lines;
  // final TextDirection textDirection;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.lines = 99,
    this.style,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      context.tr(text),
      style: style ?? getMediumStyle(),
      maxLines: lines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
