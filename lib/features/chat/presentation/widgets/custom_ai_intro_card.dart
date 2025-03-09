import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/widgets/custom_text.dart';

class CustomAiIntroCard extends StatelessWidget {
  const CustomAiIntroCard({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.icon,
    this.onTap,
    this.textColor = Colors.black,
  });
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final void Function()? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap ?? () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: backgroundColor,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white54,
                size: 38.r,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: CustomText(
                  text: text,
                  style: getMediumStyle(
                    color: textColor,
                    fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
