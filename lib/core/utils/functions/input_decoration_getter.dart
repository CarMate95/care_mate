import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/color_manager.dart';
import '../../../config/themes/text_style.dart';

mixin InputDecorationGetter {
  InputDecoration getInputDecoration({
    required BuildContext context,
    String? labelText,
    String? hintText,
    bool enabled = true,
    Widget? suffixWidget,
    Widget? prefixIcon,
    bool isRequired = true,
    TextStyle? labelStyle,
    Color fillColor = Colors.white,
    double borderRadius = 15,
    double verticalPadding = 16,
    double horizontalPadding = 16,
    double suffixIconEndPadding = 16,
    String? suffixText,
    Color? borderColor = ColorManager.grey,
  }) {
    return InputDecoration(
      focusColor: ColorManager.primaryColor,
      hoverColor: ColorManager.primaryColor,
      suffixText: suffixText,
      errorStyle: getRegularStyle(
        fontSize: 16,
        color: Colors.red,
        // context: context,
      ),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w, end: 8.w),
              child: prefixIcon,
            )
          : null,
      prefixIconConstraints: BoxConstraints(
        maxHeight: 70.h,
        // maxWidth: 140.w,
      ),
      suffixIconConstraints: BoxConstraints(
        maxHeight: 70.h,
        maxWidth: 140.w,
      ),
      prefixIconColor: ColorManager.grey,
      suffixIcon: suffixWidget != null
          ? Padding(
              padding: EdgeInsetsDirectional.only(end: suffixIconEndPadding.w),
              child: suffixWidget,
            )
          : null,
      hintText: hintText?.tr(),
      hintStyle: getRegularStyle(
        fontSize: 16,
        color: ColorManager.grey,
      ),
      labelStyle: labelStyle ??
          getRegularStyle(
            fontSize: 16,
            color: ColorManager.grey,
          ),
      contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: verticalPadding.h, horizontal: horizontalPadding.w),
      fillColor: fillColor,
      filled: true,
      labelText: labelText?.tr(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide:
            BorderSide(width: 1.w, color: borderColor ?? ColorManager.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(width: 1.w, color: ColorManager.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide:
            BorderSide(width: 1.w, color: borderColor ?? ColorManager.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(width: 1.w, color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(width: 1.w, color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(width: 1.w, color: ColorManager.grey),
      ),
    );
  }
}
