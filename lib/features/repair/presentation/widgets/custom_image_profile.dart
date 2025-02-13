import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomImageProfile extends StatelessWidget {
  const CustomImageProfile({
    super.key,
    this.alignment = Alignment.topRight,
    required this.imageIcon,
  });
  final AlignmentGeometry alignment;
  final String imageIcon;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: mediaQuery.width * 0.36,
          height: mediaQuery.height * 0.2,
          decoration: BoxDecoration(
            color: ColorManager.transparent,
            border: Border.all(color: ColorManager.primaryColor, width: 2),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: mediaQuery.width * 0.5,
          height: mediaQuery.height * 0.2,
          decoration: BoxDecoration(
            color: ColorManager.transparent,
            border: Border.all(color: ColorManager.primaryColor, width: 2),
            shape: BoxShape.circle,
          ),
        ),
        Stack(
          alignment: alignment,
          children: [
            Container(
              width: mediaQuery.width * 0.3,
              height: mediaQuery.height * 0.14,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: ColorManager.primaryColor, width: 2),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/svg/gmail_icon_svg.jpg'))),
            ),
            SvgPicture.asset(imageIcon),
          ],
        ),
      ],
    );
  }
}
