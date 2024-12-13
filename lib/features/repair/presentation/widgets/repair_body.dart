// ignore_for_file: deprecated_member_use
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:car_mate/features/repair/presentation/widgets/customfloatingactionbutton.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcreatepostwidget.dart';
import 'package:car_mate/features/repair/presentation/widgets/custompost.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RepairBody extends StatelessWidget {
  const RepairBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatingActionButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomAppBar(
                title: TextManager.requests,
                suffex: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AssetsManager.settingsIcon,
                    color: context.isDarkMode
                        ? ColorManager.lightGrey
                        : Colors.black,
                  ),
                ),
              ),
              verticalSpace(10),
              const CustomCreatePostWidget(),
              verticalSpace(5),
              Expanded(
                  child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => const CustomPost(),
                itemCount: 20,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
