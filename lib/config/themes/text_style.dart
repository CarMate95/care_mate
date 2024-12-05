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
  TextDecoration? decoration,
  double? height,
  //
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize.sp,
    fontFamily:
        RouteManager.ctx!.locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
    fontWeight: fontWeight,
    decoration: decoration,
    height: height,
  );
}

// light style
TextStyle getLightStyle({
  Color? color,
  double fontSize = 12,
  TextDecoration? decoration,
  double? height,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w300,
    decoration: decoration,
    height: height,
  );
}

// regular style
TextStyle getRegularStyle({
  Color? color,
  double fontSize = 14,
  TextDecoration? decoration,
  double? height,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w400,
    decoration: decoration,
    height: height,
  );
}

// medium style
TextStyle getMediumStyle({
  Color? color,
  double fontSize = 16,
  TextDecoration? decoration,
  double? height,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w500,
    decoration: decoration,
    height: height,
  );
}

// semi bold style
TextStyle getSemiBoldStyle({
  Color? color,
  double fontSize = 18,
  TextDecoration? decoration,
  double? height,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w600,
    decoration: decoration,
    height: height,
  );
}

// bold style
TextStyle getBoldStyle({
  Color? color,
  double fontSize = 20,
  TextDecoration? decoration,
  double? height,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w700,
    decoration: decoration,
    height: height,
  );
}
