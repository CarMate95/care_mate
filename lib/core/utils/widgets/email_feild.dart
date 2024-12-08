import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/assets_manager.dart';
import '../../../config/themes/text_manager.dart';
import 'custom_svg_icon.dart';
import 'custom_text_form_field.dart';

class EmailFeild extends StatelessWidget {
  const EmailFeild({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'user@gmail.com',
      labelText: TextManager.email,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const CustomSvgIcon(
        iconPath: AssetsManager.emailIcon,
        size: 22,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return TextManager.feildRequired.tr();
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return TextManager.pleaseEnterAValidEmailAddress.tr();
        }
        return null;
      },
    );
  }
}
