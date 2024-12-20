import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/config/themes/text_manager.dart';

void customLoadingDialog({
  required BuildContext context,
  String? text,
}) {
  showCustomAlertDialog(
    context: context,
    title: text ?? TextManager.loading.tr(),
    content: const Center(child: CircularProgressIndicator()),
  );
}
