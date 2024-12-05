import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/assets_manager.dart';
import 'custom_svg_icon.dart';

class PasswordFeild extends StatefulWidget {
  const PasswordFeild({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;

  @override
  State<PasswordFeild> createState() => _PasswordFeildState();
}

class _PasswordFeildState extends State<PasswordFeild> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      fillColor: ColorManager.lightBlack,
      obscureText: !_isPasswordVisible,
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
    );
  }
}
