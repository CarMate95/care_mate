
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar CustomAppBar(
    {Widget? actions,
    Widget? title,
    Widget? leading,
    Color color = Colors.black}) {
  return AppBar(
    backgroundColor: color,
    actions: [
      Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: actions,
      )
    ],
    title: Center(
      child:  title ?? Text(""),
    ),
    leading: Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: leading,
    ),
  );
}
