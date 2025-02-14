import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_appbar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/notifications/presentation/widgets/notifications_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
          actions: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageName.settingsScreen);
              },
              child: SvgPicture.asset(
                AssetsManager.settingIcon,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              )),
          title: Text(
            TextManager.notification.tr(),
            style: getBoldStyle(),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              ))),
      body: const NotificationsList(),
    );
  }
}
