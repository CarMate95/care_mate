import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/svg/gmail_icon_svg.jpg'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TextManager.mohamedEzzat.tr(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Manoooo@Gmail.com',
                style: TextStyle(color: context.secondaryColor)),
          ],
        ),
      ],
    );
  }
}
