import 'package:car_mate/config/themes/text_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../config/themes/assets_manager.dart';
import '../cubit/layout_cubit.dart';
import 'custom_nav_bar_item.dart';

class CustomLayoutButtonNavBar extends StatelessWidget {
  const CustomLayoutButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var layoutCubit = LayoutCubit.get(context);
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(16.r),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.black54,
          ),
          child: GNav(
            gap: 8,
            iconSize: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            duration: const Duration(milliseconds: 400),
            tabs: [
              customNavBarItem(
                text: TextManager.home,
                iconPath: AssetsManager.homeIcon,
              ),
              customNavBarItem(
                text: TextManager.repair,
                iconPath: AssetsManager.repairIcon,
              ),
              customNavBarItem(
                text: TextManager.myCar,
                iconPath: AssetsManager.carIcon,
              ),
              customNavBarItem(
                text: TextManager.aiChat,
                iconPath: AssetsManager.robotIcon,
              ),
            ],
            selectedIndex: layoutCubit.currentIndex,
            onTabChange: (index) {
              layoutCubit.changeScreen(index);
            },
          ),
        );
      },
    );
  }
}
