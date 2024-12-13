import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorManager.primaryColor,
      radius: 30,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
