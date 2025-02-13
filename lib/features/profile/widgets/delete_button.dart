import 'dart:ui';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
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
              child: _buildDeleteConfirmationDialog(context),
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

  Widget _buildDeleteConfirmationDialog(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: context.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: context.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.secondaryColor, width: 3),
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: ColorManager.primaryColor,
              size: 50,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            TextManager.areYouSure.tr(),
            style: getBoldStyle(
              fontSize: 20,
              color: context.secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            TextManager.delete.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: context.secondaryColor,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child:  ElevatedButton(
          onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
             content:  Text(TextManager.accountDeleted.tr(),
             style: getBoldStyle(
              color: ColorManager.white,
             ),
             ),
                 duration:  Duration(seconds: 3), 
                 backgroundColor: ColorManager.primaryColor,
              ),
            );
               Future.delayed( Duration(seconds: 0), () {
              Navigator.pop(context);
               Navigator.pushNamedAndRemoveUntil(context, PageName.loginScreen,(route) => false,
                 );
               });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                TextManager.deleteAccount.tr(),
                style: getBoldStyle(
                  color: ColorManager.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
