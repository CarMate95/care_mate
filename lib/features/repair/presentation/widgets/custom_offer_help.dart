import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomOfferHelp extends StatelessWidget {
  const CustomOfferHelp({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: ColorManager.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.green, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 5,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Text(
                  TextManager.offerhelp.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
