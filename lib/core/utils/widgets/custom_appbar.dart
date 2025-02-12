import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: non_constant_identifier_names
AppBar CustomAppBar({
  Widget? actions,
  Widget? title,
  Widget? leading,
  Color? color = ColorManager.transparent,
}) {
  return AppBar(
    backgroundColor: color,
    actions: [
      Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: actions,
      )
    ],
    title: Center(
      child: title ?? const Text(""),
    ),
    leading: Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: leading,
    ),
  );
}
