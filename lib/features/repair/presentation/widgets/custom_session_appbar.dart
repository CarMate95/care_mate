import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSessionAppbar extends StatelessWidget {
  const CustomSessionAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: CustomAppBar(
            enbleBackIcon: true,
            onBack: () {
              Navigator.of(context).pop();
            },
            title: Text(
              TextManager.sessions.tr(),
              style: getMediumStyle(
                fontSize: 24.sp,
                color: context.secondaryColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PageName.settingsScreen);
            },
            child: SvgPicture.asset(
              AssetsManager.settingIcon,
              color: context.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
