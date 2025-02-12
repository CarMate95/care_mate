import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_mate/config/themes/color_manager.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.color = ColorManager.grey,
    this.thickness = 1,
  });
  final Color color;
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness.h,
    );
  }
}
