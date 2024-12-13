import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:flutter/material.dart';

class CustomPost extends StatelessWidget {
  const CustomPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: double.infinity,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomCircularAvatar(),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'مارك ويلسون'),
                      CustomText(text: '@markkkkk222'),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                            color: Color(0xff00AAFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      horizontalSpace(5),
                      const CustomText(text: 'منذ 6 سعات'),
                    ],
                  ),
                ],
              ),
              const FractionallySizedBox(
                widthFactor: 0.41,

                //
                child: Divider(
                  color: Color(0xff0E0E0E),
                  thickness: 2,
                ),
              ),
              const CustomText(
                  lines: 5,
                  text:
                      'يا الجميع! أحتاج إلى بعض المساعدة في سيارتي. لقد كان الأمر يمنحني مشكلة ، ولست متأكدًا من الخطأ ، خاصة عندما أبدأ أو يقود بسرعة أقل.إليك ما يحدث: الضوضاء هناك صوت غريب قاسي قادم من منطقة المحركإليك ما يحدث: الضوضاء هناك صوت غريب قاسي قادم من منطقة المحرك'),
            ],
          ),
        ),
      ),
    );
  }
}
