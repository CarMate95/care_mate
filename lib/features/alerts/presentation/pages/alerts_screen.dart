import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_appbar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_cards_list.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: title()),
      body: const AlertCardsList(),
    );
  }

  ClipRRect title() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.sp),
        child: Text(
          "Alert",
          style: getBoldStyle(),
        ));
  }
}
