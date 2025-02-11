import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomfractionallySizedbox extends StatelessWidget {
  const CustomfractionallySizedbox(
      {super.key, this.align, this.widthFactor, this.color});
  final AlignmentGeometry? align;
  final double? widthFactor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: align ?? Alignment.center,
      child: CustomDivider(
        thickness: 0.5,
        color: color??Colors.grey,
      ),
    );
  }
}
