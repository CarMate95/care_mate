import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'gesture_alert_card.dart';

class AlertCardsList extends StatelessWidget {
  const AlertCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        GestureAlertCard(
          title: TextManager.checkEngine.tr(),
          image: Image.asset(AssetsManager.engineCheckImage),
          alertMessage: TextManager.checkEngineAlertMessage.tr(),
          alertTitle: TextManager.engineWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.brakeWarning.tr(),
          image: Image.asset(AssetsManager.brakeWarning),
          alertMessage: TextManager.brakeWarningAlertMessage.tr(),
          alertTitle: TextManager.brakeWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.tirePressure.tr(),
          image: Image.asset(AssetsManager.tirePressure),
          alertMessage: TextManager.tirePressureAlertMessage.tr(),
          alertTitle: TextManager.tirePressureWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.temperatureWarning.tr(),
          image: Image.asset(AssetsManager.temperatureImage),
          alertMessage: TextManager.temperatureWarningAlertMessage.tr(),
          alertTitle: TextManager.temperatureWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.batteryWarning.tr(),
          image: Image.asset(AssetsManager.battery),
          alertMessage: TextManager.batteryWarningAlertMessage.tr(),
          alertTitle: TextManager.batteryWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.absWarning.tr(),
          image: Image.asset(AssetsManager.abs),
          alertMessage: TextManager.absWarningAlertMessage.tr(),
          alertTitle: TextManager.absWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.checkEngine.tr(),
          image: Image.asset(AssetsManager.engineCheckImage),
          alertMessage: TextManager.checkEngineAlertMessage.tr(),
          alertTitle: TextManager.engineWarningLight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.absWarning.tr(),
          image: Image.asset(AssetsManager.abs),
          alertMessage: TextManager.absWarningAlertMessage.tr(),
          alertTitle: TextManager.absWarningLight.tr(),
        ),
      ],
    );
  }
}
