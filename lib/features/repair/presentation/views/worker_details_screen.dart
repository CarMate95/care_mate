import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_appbar.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_rating.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/worker_model.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_image_profile.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_row_account_details.dart';
import 'package:flutter/material.dart';

class WorkerDetailsScreen extends StatelessWidget {
  final WorkerModel worker;

  const WorkerDetailsScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: CustomSvgIcon(
                  iconPath: AssetsManager.backIcon,
                  color: context.secondaryColor,
                ),
              ),
              title: CustomText(
                text: TextManager.accountDetails,
                style:
                    getMediumStyle(color: context.secondaryColor, fontSize: 24),
              ),
            ),
            verticalSpace(30),
            CustomImageProfile(
              imageIcon: worker.user.profilePhoto.isNotEmpty
                  ? worker.user.profilePhoto.first
                  : 'assets/svg/default_image.jpg',
            ),
            verticalSpace(10),
            CustomText(
              text: '${worker.user.firstName} ${worker.user.lastName}',
              style:
                  getMediumStyle(color: context.secondaryColor, fontSize: 24),
            ),
            CustomText(
              text: worker.user.email,
              style:
                  getMediumStyle(color: context.secondaryColor, fontSize: 12),
            ),
            verticalSpace(10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: context.tertiaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 30.0),
                  child: Column(
                    children: [
                      CustomRowAccountDetails(
                        icon: Icons.person,
                        iconColor: Colors.red,
                        text:
                            '${worker.user.firstName} ${worker.user.lastName}',
                      ),
                      verticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomDivider(color: context.secondaryColor),
                      ),
                      verticalSpace(10),
                      CustomRowAccountDetails(
                        icon: Icons.call,
                        iconColor: Colors.green,
                        text: worker.user.phone,
                      ),
                      verticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomDivider(color: context.secondaryColor),
                      ),
                      verticalSpace(10),
                      CustomRowAccountDetails(
                        icon: Icons.location_on_sharp,
                        iconColor: Colors.blue,
                        text: worker.location,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.tertiaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const CustomText(
                        text: TextManager.ratingmessage,
                        textAlign: TextAlign.center,
                      ),
                      const CustomText(
                        text: TextManager.ratingMessage2,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(5),
                      const CustomRating(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: TextManager.bad,
                            style: getMediumStyle(
                                fontSize: 12, color: context.secondaryColor),
                          ),
                          CustomText(
                            text: TextManager.excellent,
                            style: getMediumStyle(
                                fontSize: 12, color: context.secondaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
