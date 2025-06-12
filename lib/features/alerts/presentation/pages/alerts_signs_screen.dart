import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alerts_signs_toggle.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';

class AlertsSignsScreen extends StatelessWidget {
  const AlertsSignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: SignAlertToggle(),
    );
  }
}
