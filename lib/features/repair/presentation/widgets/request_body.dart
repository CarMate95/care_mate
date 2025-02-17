// ignore_for_file: deprecated_member_use
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_floating_action_button.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcreatepostwidget.dart';
import 'package:car_mate/features/repair/presentation/widgets/customlistviewpost.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RequestsBody extends StatelessWidget {
  const RequestsBody({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      horizontalPadding: 0,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ListView(
            padding: const EdgeInsets.all(0),
            children: [
              CustomAppBar(
                enbleBackIcon: false,
                title: CustomText(text: TextManager.requests.tr()),
                suffex: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageName.settingsScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset(
                      AssetsManager.settingsIcon,
                      color: context.isDarkMode
                          ? ColorManager.lightGrey
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              verticalSpace(10),
              const CustomCreatePostWidget(),
              const CustomListViewPosts(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, PageName.createPostScreen);
              },
              icon: Icons.person,
              backgroundColor: ColorManager.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
