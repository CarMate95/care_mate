import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../layout/presentation/cubit/layout_cubit.dart';

class UseAIWidget extends StatelessWidget {
  const UseAIWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        LayoutCubit.get(context).changeScreen(3);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: 170.h,
          width: 155.w,
          color: context.isDarkMode
              ? ColorManager.darkGrey
              : ColorManager.lightGrey,
          child: Image.asset(
            AssetsManager.useAI,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
