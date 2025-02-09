import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar(
      {super.key, this.backgroundColor = Colors.redAccent});
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: SvgPicture.asset(
        AssetsManager.personIcon,
        fit: BoxFit.cover,
      ),
    );
  }
}
