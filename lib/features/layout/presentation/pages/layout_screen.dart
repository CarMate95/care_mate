import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/layout_cubit.dart';
import '../widgets/custom_layout_button_nav_bar.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(screens: [
        Center(
          child: Text(
            'Home',
            style: getBoldStyle(color: ColorManager.primaryColor),
          ),
        ),
        Center(
          child: Text(
            'Repair',
            style: getBoldStyle(color: ColorManager.primaryColor),
          ),
        ),
        Center(
          child: Text(
            'My Car ',
            style: getBoldStyle(color: ColorManager.primaryColor),
          ),
        ),
        Center(
          child: Text(
            'Ai Chat',
            style: getBoldStyle(color: ColorManager.primaryColor),
          ),
        ),
      ]),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          var layoutCubit = LayoutCubit.get(context);
          return Scaffold(
            backgroundColor: context.scaffoldBackgroundColor,
            body: layoutCubit.screens[layoutCubit.currentIndex],
            bottomNavigationBar: const CustomLayoutButtonNavBar(),
          );
        },
      ),
    );
  }
}
