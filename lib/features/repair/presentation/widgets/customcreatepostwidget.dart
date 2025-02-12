import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomCreatePostWidget extends StatelessWidget {
  const CustomCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, PageName.createPostScreen),
      child: Container(
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CustomCircularAvatar(),
              horizontalSpace(5),
              Text(
                TextManager.whatHappening.tr(),
                style: getLightStyle(
                  color: context.secondaryColor,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.photo_library,
                color: context.secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//  TextField(
//         // onTap: () {
//         //   Navigator.pushNamed(context, PageName.createPostScreen);
//         // },
//         cursorColor: context.isDarkMode ? ColorManager.white : Colors.black,
//         decoration: InputDecoration(
          // suffixIcon: Icon(
          //   Icons.photo_library,
          //   color = context.isDarkMode
          //       ? ColorManager.lightGrey
          //       : ColorManager.black,
          // ),
//           border: InputBorder.none,
//           hintText: TextManager.whatHappening.tr(),
//           hintStyle: getLightStyle(
//             color: context.isDarkMode ? ColorManager.lightGrey : Colors.black,
//           ),
//           contentPadding: const EdgeInsets.all(15),
//           prefixIcon: const CustomCircularAvatar(),
//         ),
//       ),