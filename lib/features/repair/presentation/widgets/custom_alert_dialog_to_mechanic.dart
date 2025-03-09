
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/features/repair/data/repo/request_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showAlertDialogToMechanic(BuildContext context, int postId, int workerId,String userName) {
  var mediaQuery = MediaQuery.of(context).size;
  TextEditingController noteController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  final OfferRepository offerRepository = OfferRepository();

  showCustomAlertDialog(
    context: context,
    title: TextManager.requests,
    content: Column(
      children: [
        Text('${TextManager.too.tr()} : userName ',
            style: getLightStyle(color: context.secondaryColor)),
        verticalSpace(10),
        TextField(
          controller: noteController,
          decoration: InputDecoration(
            labelText: TextManager.note.tr(),
          ),
        ),
        verticalSpace(10),
        TextField(
          controller: cashController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: TextManager.cash.tr(),
          ),
        ),
        verticalSpace(20),
        CustomElevatedButton(
          onPressed: () async {
            final note = noteController.text;
            final cash = cashController.text;

            if (note.isNotEmpty && cash.isNotEmpty) {
              try {
                await offerRepository.createOffer(
                  workerId,
                  postId,
                  cash,
                  note,
                );

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Offer sent successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to send offer: \$e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
