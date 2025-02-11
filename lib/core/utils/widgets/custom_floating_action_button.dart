import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });
  final IconData icon;
  final Color? backgroundColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgroundColor,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: ColorManager.lightGrey,
        size: 30,
      ),
    );
  }
}
