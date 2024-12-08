import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_manager.dart';
import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';

class FirstNameAndLastName extends StatelessWidget {
  const FirstNameAndLastName({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
  });
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: firstNameController,
            prefixIcon: Icon(
              Icons.person_outline,
              size: 24.sp,
              color: ColorManager.grey,
            ),
            labelText: TextManager.firstName,
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: CustomTextFormField(
            controller: lastNameController,
            prefixIcon: const Icon(
              Icons.person_outline,
              size: 24,
              color: ColorManager.grey,
            ),
            labelText: TextManager.lastName,
          ),
        ),
      ],
    );
  }
}
