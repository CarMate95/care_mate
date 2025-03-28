import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../core/utils/constants_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (ConstantsManager.token != null &&
          ConstantsManager.rememberMe == true) {
        Navigator.pushReplacementNamed(context, PageName.layoutScreen);
      } else {
        Navigator.pushReplacementNamed(context, PageName.onBoardingScreen);
      }

      // Navigator.pushReplacementNamed(context, PageName.onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 220.w,
          height: 220.w,
          child: SvgPicture.asset(
            context.isDarkMode
                ? AssetsManager.logoDark
                : AssetsManager.logoLight,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
