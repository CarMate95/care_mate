import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showAlertDialogToMechanic(BuildContext context) {
  showCustomAlertDialog(
    context: context,
    title: TextManager.offerhelp,
    content: Column(
      children: [
        Text('${TextManager.too.tr()} : Mohamed Sayed', style: getLightStyle()),
        verticalSpace(10),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 2,
                        color: ColorManager.grey,
                      ),
                    ),
                    child: Text(
                      '''Hey! I saw your post and can help with these issues. The rattling and sluggish performance could be engine or exhaust-related, while the vibrations and check engine light might point to spark plug or fuel issues. The brake grinding likely means the pads need attention.
If you’d like, bring it by my shop for a full diagnostic, and I’ll walk you through the findings. Let me know if you want to set something up!''',
                      style: getLightStyle(),
                    ),
                  ),
                  verticalSpace(20),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorManager.lightGrey),
                            color: ColorManager.transparent),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: getLightStyle(fontSize: 16),
                              children: const [
                                TextSpan(text: "500-900"),
                                TextSpan(
                                    text: " \$",
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -13,
                        left: 20,
                        child: Text(TextManager.cash.tr(),
                            style: getMediumStyle()),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: -13,
                left: 20,
                child: Text(TextManager.note.tr(), style: getMediumStyle()),
              ),
            ],
          ),
        ),
        verticalSpace(20),
        CustomElevatedButton(onPressed: () {}, text: TextManager.sent.tr())
      ],
    ),
  );
}
