import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/text_style.dart';

class RepairScreen extends StatelessWidget {
  const RepairScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Repair',
        style: getSemiBoldStyle(color: context.onPrimayColor),
      ),
    );
  }
}
