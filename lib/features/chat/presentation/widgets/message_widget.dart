import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'animated_selectable_text.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFromUser) ...{
           CircleAvatar(
            radius: 24.r,
            backgroundColor: ColorManager.primaryColor,
            child: const CustomSvgIcon(
              iconPath: AssetsManager.robotIcon,
              size: 28,
              color: ColorManager.white,
            ),
          ),
          const SizedBox(width: 10),
        },
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isFromUser ? size.width * 0.8 : size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isFromUser ? ColorManager.grey : ColorManager.darkGrey,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                // if (text case final text?) MarkdownBody(data: text),
                if (text case final text?) ...{
                  isFromUser
                      ? SelectableText(
                          text,
                          style: getMediumStyle(
                            color: Colors.black,
                          ),
                        )
                      : AnimatedSelectableText(
                          fullText: text,
                          textStyle: getMediumStyle(
                            color: Colors.white,
                          ),
                          // animationDuration: const Duration(milliseconds: 50),
                        ),
                },
                if (image case final image?) image,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
