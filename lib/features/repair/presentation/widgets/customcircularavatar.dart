import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCircularAvatat extends StatelessWidget {
  const CustomCircularAvatat({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: SvgPicture.asset(
          AssetsManager.personIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
