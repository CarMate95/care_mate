import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../config/themes/assets_manager.dart';
import '../../../config/themes/text_manager.dart';

class LocationFeild extends StatelessWidget {
  const LocationFeild({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      prefixIcon: const CustomSvgIcon(
        iconPath: AssetsManager.locatinIcon,
        size: 24,
      ),
      labelText: TextManager.location,
      hintText: TextManager.enterYourLocation,
    );
  }
}
