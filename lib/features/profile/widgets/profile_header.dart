import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/svg/gmail_icon_svg.jpg'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextManager.MohamedEzzat.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Manoooo@Gmail.com', style: TextStyle(color: context.secondaryColor)),
          ],
        ),
      ],
    );
  }
}
