import 'package:car_mate/config/routes/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// This the base function and it will be called
/// from all other function in this file
TextStyle _getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  Color? color,
  //
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontFamily:
        RouteManager.ctx!.locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
    fontWeight: fontWeight,
  );
}

// light style
TextStyle getLightStyle({
  Color? color,
  double fontSize = 12,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w300,
  );
}

// regular style
TextStyle getRegularStyle({
  Color? color,
  double fontSize = 14,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w400,
  );
}

// medium style
TextStyle getMediumStyle({
  Color? color,
  double fontSize = 16,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w500,
  );
}

// semi bold style
TextStyle getSemiBoldStyle({
  Color? color,
  double fontSize = 18,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w600,
  );
}

// bold style
TextStyle getBoldStyle({
  Color? color,
  double fontSize = 20,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w700,
  );
}
