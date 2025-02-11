import 'dart:ui';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
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
              child: _buildLogoutConfirmationDialog(context),
            );
          },
        );
      },
      child: ListTile(
        leading: Icon(Icons.logout, color:ColorManager.primaryColor,),
        title: Text(TextManager.logout.tr(),
          style: getBoldStyle(
            color: ColorManager.primaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutConfirmationDialog(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color:context.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.secondaryColor, width: 3),
            ),
            child: Icon(
              Icons.logout,
              color: ColorManager.primaryColor,
              size: 50,
            ),
          ),
          SizedBox(height: 16),
          Text(
            TextManager.areYouSure.tr(),
            style: getBoldStyle(
              fontSize: 20,
              color: context.secondaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(TextManager.logoutWarning.tr(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: context.secondaryColor,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, '/loginScreen');
                print('Logged Out');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(TextManager.logout.tr(),
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
