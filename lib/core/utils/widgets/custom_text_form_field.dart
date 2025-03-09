import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/color_manager.dart';
import '../../../config/themes/text_manager.dart';
import '../../../config/themes/text_style.dart';
import '../functions/input_decoration_getter.dart';
import '../responsive_methods.dart';

class CustomTextFormField extends StatelessWidget with InputDecorationGetter {
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final double suffixIconEndPadding;
  final String? initialValue;
  final Widget? prefixIcon;
  final bool obscureText;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  final Function(String?)? onchangeFun;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isEn;
  final bool readOnly;
  final Function? onEditingComplete;
  final int maxLines;
  final bool enabled;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool isRequired;
  final double verticalPadding;
  final double horizontalPadding;
  final double? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final bool enabletopLable;
  final Color textValueColor;
  final String? suffixText;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    this.readOnly = false,
    this.textValueColor = ColorManager.grey,
    this.labelStyle,
    this.suffixText,
    this.autofillHints,
    this.suffixIconEndPadding = 16,
    this.labelText,
    this.style,
    this.inputFormatters,
    this.hintText,
    this.fillColor,
    this.borderRadius = 15,
    this.verticalPadding = 12,
    this.horizontalPadding = 12,
    this.maxLines = 1,
    this.initialValue,
    this.onchangeFun,
    this.suffixWidget,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.onEditingComplete,
    this.enabled = true,
    this.isEn = false,
    this.onFieldSubmitted,
    this.isRequired = true,
    this.borderColor = Colors.transparent,
    this.enabletopLable = false,
    this.minLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.focusNode,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      readOnly: readOnly,
      autofillHints: autofillHints,
      maxLength: maxLength,
      initialValue: initialValue,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      scrollPadding: EdgeInsets.zero,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      keyboardType: keyboardType,
      cursorHeight: isMobile(context) ? 20.h : 30.h,
      cursorColor: Colors.black,
      maxLines: maxLines,
      minLines: minLines,
      obscuringCharacter: '*',
      buildCounter: isTablet(context) && maxLength != null
          ? (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) {
              return Text(
                "$currentLength/$maxLength",
                style: getRegularStyle(color: ColorManager.grey),
              );
            }
          : null,
      style: getMediumStyle(fontSize: 16, color: textValueColor),
      decoration: getInputDecoration(
        context: context,
        hintText: hintText,
        enabled: enabled,
        isRequired: isRequired,
        fillColor: context.tertiaryColor,
        prefixIcon: prefixIcon,
        // labelText: labelText,
        suffixText: suffixText,
        suffixWidget: suffixWidget,
        suffixIconEndPadding: suffixIconEndPadding,
        borderRadius: borderRadius ?? 15.r,
        verticalPadding: verticalPadding.h,
        horizontalPadding: horizontalPadding,
        borderColor: borderColor,
        labelText: labelText,
        labelStyle: labelStyle,
      ),
      onChanged: onchangeFun,
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return TextManager.feildRequired.tr();
            }
            return null;
          },
      inputFormatters: inputFormatters,
    );
  }
}
