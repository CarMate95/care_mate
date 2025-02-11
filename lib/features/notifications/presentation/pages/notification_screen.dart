import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_appbar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/notifications/presentation/widgets/notifications_list.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
          actions: SvgPicture.asset(AssetsManager.settingIcon),
          title: Text(
            "Notification",
            style: getBoldStyle(),
          ),
          leading: SvgPicture.asset(AssetsManager.backIcon)),
      body: const NotificationsList(),
    );
  }
}
