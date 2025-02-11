import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_mate/config/themes/color_manager.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color, this.thickness});
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? ColorManager.grey.withOpacity(0.4),
      thickness: thickness ?? 1.h,
    );
  }
}
