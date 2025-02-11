import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:flutter/material.dart';

class CustomPost extends StatelessWidget {
  const CustomPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        width: double.infinity,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PageName.requestDetails);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomCircularAvatar(),
                    horizontalSpace(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'مارك ويلسون',
                              style: getMediumStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            horizontalSpace(5),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xff00AAFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            horizontalSpace(5),
                            CustomText(
                              text: 'منذ 6 ساعات',
                              style: getLightStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        CustomText(
                          text: '@markkkkk222',
                          style: getLightStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(5),
                FractionallySizedBox(
                  widthFactor: 0.3,
                  child: CustomDivider(
                    color: ColorManager.black,
                    thickness: 2,
                  ),
                ),
                CustomText(
                    lines: 5,
                    style: getLightStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                    text:
                        ' قاسي قادم من منطقة المح قاسي قادم من منطقة المحيا الجميع! أحتاج إلى بعض المساعدة في سيارتي. لقد كان الأمر يمنحني مشكلة ، ولست متأكدًا من الخطأ ، خاصة عندما أبدأ أو يقود بسرعة أقل.إليك ما يحدث: الضوضاء هناك صوت غريب قاسي قادم من منطقة المحركإليك ما يحدث: الضوضاء هناك صوت غريب قاسي قادم من منطقة المحرك'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
