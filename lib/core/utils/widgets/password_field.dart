import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/assets_manager.dart';
import 'custom_svg_icon.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.onchangeFun,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String?)? onchangeFun;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      obscureText: !_isPasswordVisible,
      onchangeFun: widget.onchangeFun,
      suffixWidget: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: ColorManager.grey,
          size: 22,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      prefixIcon: const CustomSvgIcon(
        iconPath: AssetsManager.lockIcon,
        size: 22,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return TextManager.feildRequired.tr();
        } else if (value.length < 6) {
          return TextManager.passwordValidation.tr();
        }
        return null;
      },
    );
  }
}
