import 'package:car_mate/config/themes/text_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/assets_manager.dart';
import 'custom_svg_icon.dart';
import 'custom_text_form_field.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      prefixIcon: const CustomSvgIcon(
        iconPath: AssetsManager.callIcon,
        size: 20,
      ),
      keyboardType: TextInputType.phone,
      labelText: TextManager.phoneNumber,
      validator: (value) {
        if (value!.isEmpty) {
          return TextManager.feildRequired.tr();
        } else if (value.length < 11) {
          return TextManager.phoneNumberMustBe11Digits.tr();
        }
        return null;
      },
    );
  }
}
