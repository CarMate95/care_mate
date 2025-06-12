import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'gesture_alert_card.dart';

class SignsCardsList extends StatelessWidget {
  const SignsCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      children: [
        GestureAlertCard(
          title: TextManager.turnLeft.tr(),
          image: Image.asset(AssetsManager.turnLeftSign),
          alertMessage: TextManager.turnLeftMessage.tr(),
          alertTitle: TextManager.turnLeft.tr(),
        ),
        GestureAlertCard(
          title: TextManager.turnRight.tr(),
          image: Image.asset(AssetsManager.turnRightSign),
          alertMessage: TextManager.turnRightMessage.tr(),
          alertTitle: TextManager.turnRight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.stop.tr(),
          image: Image.asset(AssetsManager.stopSign),
          alertMessage: TextManager.stopMessage.tr(),
          alertTitle: TextManager.stop.tr(),
        ),
        GestureAlertCard(
          title: TextManager.noParking.tr(),
          image: Image.asset(AssetsManager.noParkingSign),
          alertMessage: TextManager.noParkingMessage.tr(),
          alertTitle: TextManager.noParking.tr(),
        ),
        GestureAlertCard(
          title: TextManager.noUTurns.tr(),
          image: Image.asset(AssetsManager.noUTurnSign),
          alertMessage: TextManager.noUTurnsMessage.tr(),
          alertTitle: TextManager.noUTurns.tr(),
        ),
        GestureAlertCard(
          title: TextManager.keepLeftRight.tr(),
          image: Image.asset(AssetsManager.keepLeftRightSign),
          alertMessage: TextManager.keepLeftRightMessage.tr(),
          alertTitle: TextManager.keepLeftRight.tr(),
        ),
        GestureAlertCard(
          title: TextManager.sharedPath.tr(),
          image: Image.asset(AssetsManager.sharedPathSign),
          alertMessage: TextManager.sharedPathMessage.tr(),
          alertTitle: TextManager.sharedPath.tr(),
        ),
        GestureAlertCard(
          title: TextManager.cycleway.tr(),
          image: Image.asset(AssetsManager.cyclewaySign),
          alertMessage: TextManager.cyclewayMessage.tr(),
          alertTitle: TextManager.cycleway.tr(),
        ),
      ],
    );
  }
}
