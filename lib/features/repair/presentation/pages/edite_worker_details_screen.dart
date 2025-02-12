import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_image_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EditeWorkerDetailsScreen extends StatelessWidget {
  const EditeWorkerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                const CustomAppBar(title: TextManager.accountDetails),
                verticalSpace(30),
                const CustomImageProfile(
                    imageIcon: 'assets/svg/Edit.svg',
                    alignment: Alignment.bottomRight),
                verticalSpace(20),
                CustomText(
                  text: 'Mohamed Ezzat',
                  style: getMediumStyle(
                      color: context.secondaryColor, fontSize: 24),
                ),
                CustomText(
                  text: '@11Elmasryyyy',
                  style: getMediumStyle(
                      color: context.secondaryColor, fontSize: 12),
                ),
              ],
            ),
            verticalSpace(50),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: TextManager.firstName.tr(),
                        labelStyle: const TextStyle(color: ColorManager.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: context.scaffoldBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: context.tertiaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: context.tertiaryColor, width: 2),
                        ),
                      ),
                      style: TextStyle(
                        color: context.secondaryColor,
                      ),
                    ),
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: TextManager.lastName.tr(),
                        labelStyle: const TextStyle(color: ColorManager.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        fillColor: context.scaffoldBackgroundColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: context.tertiaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: context.tertiaryColor, width: 2),
                        ),
                      ),
                      style: TextStyle(
                        color: context.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: TextManager.email.tr(),
                    labelStyle: const TextStyle(color: ColorManager.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: context.scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: context.tertiaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: context.tertiaryColor, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    color: context.secondaryColor,
                  ),
                ),
              ),
            ),
            verticalSpace(30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: TextManager.phone.tr(),
                    labelStyle: const TextStyle(color: ColorManager.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: context.scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: context.tertiaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: context.tertiaryColor, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    color: context.secondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
