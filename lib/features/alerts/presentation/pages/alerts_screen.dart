import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_cards_list.dart';
import 'package:car_mate/features/alerts/presentation/wigdets/alert_screen_appbar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: alertScreenAppBar(context),
      body: const AlertCardsList(),
    );
  }
}
