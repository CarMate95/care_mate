import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_toggle_button.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_cards_list.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/sign_cards_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SignAlertToggle()));

class SignAlertToggle extends StatefulWidget {
  const SignAlertToggle({super.key});

  @override
  State<SignAlertToggle> createState() => _SignAlertToggleState();
}

class _SignAlertToggleState extends State<SignAlertToggle> {
  bool isAlertsSelected = true;

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Colors.white;
    final Color unselectedColor = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Toggle Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButton(
                text: TextManager.alerts.tr(),
                isSelected: isAlertsSelected,
                onTap: () => setState(() => isAlertsSelected = true),
              ),
              ToggleButton(
                text: TextManager.signs.tr(),
                isSelected: !isAlertsSelected,
                onTap: () => setState(() => isAlertsSelected = false),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Grid
          Expanded(
            child: isAlertsSelected
                ? const AlertCardsList()
                : const SignsCardsList(),
          ),
        ],
      ),
    );
  }
}
