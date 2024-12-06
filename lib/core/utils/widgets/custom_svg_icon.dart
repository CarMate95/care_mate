import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../responsive_methods.dart';

class CustomSvgIcon extends StatelessWidget {
  final String iconPath;
  final double size;
  final Color? color;
  final BoxFit fit;
  const CustomSvgIcon({
    super.key,
    required this.iconPath,
    this.size = 30,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (size * (isTablet(context) ? 0.75 : 1)).w,
      child: AspectRatio(
        aspectRatio: 1,
        child: SvgPicture.asset(
          iconPath,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          fit: fit,
        ),
      ),
    );
  }
}
