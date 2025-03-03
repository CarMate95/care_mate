import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/enums/user_type.dart';
import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class CustomRole extends StatefulWidget {
  const CustomRole({super.key, this.onSelectedType});
  final Function(UserRole? userRole)? onSelectedType;

  @override
  State<CustomRole> createState() => _CustomRoleState();
}

class _CustomRoleState extends State<CustomRole> {
  UserRole? userRole;
  final ExpansionTileController controller = ExpansionTileController();
  // bool enableValidation = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ExpansionTile(
          controller: controller,
          backgroundColor: context.tertiaryColor,
          collapsedBackgroundColor: context.tertiaryColor,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          // tilePadding: EdgeInsets.all(10.r),
          title: CustomText(
            text: userRole == null
                ? TextManager.chooseYourRole
                : userRole == UserRole.customer
                    ? TextManager.personalDriver
                    : TextManager.vehicleWorker,
            style: getBoldStyle(
              fontSize: 16,
              color: context.secondaryColor,
            ),
          ),
          iconColor: context.onPrimayColor,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: context.scaffoldBackgroundColor,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        userRole = UserRole.customer;
                        controller.collapse();
                        widget.onSelectedType!(UserRole.customer);
                        setState(() {});
                      },
                      text: TextManager.personalDriver,
                      backgroundColor: context.tertiaryColor,
                      style: getSemiBoldStyle(
                        fontSize: 16,
                        color: context.secondaryColor,
                      ),
                    ),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        userRole = UserRole.worker;
                        controller.collapse();
                        widget.onSelectedType!(UserRole.worker);
                        setState(() {});
                      },
                      text: TextManager.vehicleWorker,
                      backgroundColor: context.tertiaryColor,
                      style: getSemiBoldStyle(
                        fontSize: 16,
                        color: context.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
