import 'dart:ui';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_build_confirmation_dialog.dart';
import 'package:car_mate/features/profile/widgets/profile_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: context.scaffoldBackgroundColor,
          builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: customBuildConfirmationDialog(
                context: context,
                description: TextManager.delete.tr(),
                btnText: TextManager.deleteAccount.tr(),
                onPressed: () async {
                  bool isDeleted = await ProfileService.deleteProfile();

                  if (isDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          TextManager.accountDeleted.tr(),
                          style: getBoldStyle(color: ColorManager.white),
                        ),
                        duration: const Duration(seconds: 3),
                        backgroundColor: ColorManager.primaryColor,
                      ),
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        PageName.loginScreen,
                        (route) => false,
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "❌ فشل حذف الحساب، يرجى المحاولة لاحقًا",
                          style: getBoldStyle(color: ColorManager.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            );
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            TextManager.deleteAccount.tr(),
            style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 120,
            height: 2,
            color: ColorManager.primaryColor,
          ),
        ],
      ),
    );
  }
}
