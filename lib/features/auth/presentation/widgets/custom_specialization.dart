import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/material.dart';

const List<String> _list = [
  'Mechanic',
  'Electrical',
  'CarPlumber',
];

class CustomSpecialization extends StatelessWidget {
  const CustomSpecialization({super.key, this.onChanged});
  final dynamic Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      hintText: 'Select specialization',
      items: _list,
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please select specialization';
        }
        return null;
      },
      decoration: const CustomDropdownDecoration(
        closedFillColor: ColorManager.darkGrey,
        expandedFillColor: ColorManager.darkGrey,
      ),
    );
  }
}
