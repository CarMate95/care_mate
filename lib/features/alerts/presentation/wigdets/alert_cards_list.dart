import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:flutter/material.dart';

import 'gesture_alert_card.dart';

class AlertCardsList extends StatelessWidget {
  const AlertCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, ),
      children: const [
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
        GestureAlertCard(
          title: "Check engine",
          image: AssetsManager.settingIcon,
        ),
      ],
    );
  }
}
