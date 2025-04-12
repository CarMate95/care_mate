import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text_form_field.dart';
import 'package:car_mate/features/repair/data/repo/request_repo_implementation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showAlertDialogToMechanic(
    BuildContext context, int postId, int workerId, String userName) {
  TextEditingController noteController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  OfferRepositoryImplementation offerRepository =
      OfferRepositoryImplementation();
  showCustomAlertDialog(
    context: context,
    title: TextManager.requests,
    content: Column(
      children: [
        Text('${TextManager.too.tr()} : $userName ',
            style: getLightStyle(color: context.secondaryColor)),
        verticalSpace(10),
        CustomTextFormField(
          controller: noteController,
          maxLines: 5,
          labelText: TextManager.note.tr(),
        ),
        verticalSpace(10),
        CustomTextFormField(
          controller: cashController,
          keyboardType: TextInputType.number,
          labelText: TextManager.cash.tr(),
        ),
        verticalSpace(20),
        CustomElevatedButton(
          onPressed: () async {
            final note = noteController.text;
            final cash = cashController.text;

            if (note.isNotEmpty && cash.isNotEmpty) {
              await offerRepository.createOffer(
                workerId,
                postId,
                cash,
                note,
                context,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill in all fields'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          text: TextManager.sent.tr(),
        )
      ],
    ),
  );
}
