import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_alert_dialog_to_mechanic.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_button_offer_help.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RequestDetailsBody extends StatelessWidget {
  const RequestDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            CustomAppBar(
              enbleBackIcon: true,
              title: CustomText(text: TextManager.requests.tr()),
              suffex: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageName.settingsScreen);
                  },
                  child: SvgPicture.asset(
                    AssetsManager.settingsIcon,
                    // ignore: deprecated_member_use
                    color: context.secondaryColor,
                  ),
                ),
              ),
            ),
            verticalSpace(20),
            Column(
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
                                color: context.secondaryColor,
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
                              style:
                                  getLightStyle(color: context.secondaryColor)
                                      .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        CustomText(
                            text: '@markkkkk222', style: getLightStyle()),
                      ],
                    ),
                  ],
                ),
                verticalSpace(5),
                const FractionallySizedBox(
                  widthFactor: 0.3,
                  child: CustomDivider(
                    // color: Color(0xff0E0E0E),
                    thickness: 2,
                  ),
                ),
              ],
            ),
            CustomText(
              text: '''
        "مرحبًا بالجميع! أنا بحاجة إلى بعض المساعدة في سيارتي. لقد كان الأمر يمنحني المتاعب مؤخرًا ، ولست متأكدًا مما يجري.
        إليك ما لاحظته:
        
        الضوضاء: هناك صوت غريب قاسي قادم من منطقة المحرك ، خاصة عندما أبدأ أو أقوده بسرعات أقل. الضجيج أسوأ عندما أذهب إلى المطبات ، ويمكنني أيضًا سماعها بصوت ضعيف عندما أتسارع من التوقف.
        
        الأداء: تشعر السيارة بطيئًا حقًا ، مثل أنها تكافح من أجل التسارع كما تفعل عادة. صعود الصعود ، ويتردد حتى عندما أضغط على الغاز. يبدو أنني أملأ أكثر من مرة ، لذا فهو يحترق وقود أكثر من المعتاد.
        
        ضوء التحذير: جاء ضوء محرك الفحص بالأمس ولم يختف. حاولت إعادة تشغيل السيارة عدة مرات ، لكن الضوء لا يزال قيد التشغيل. لا أعرف ما إذا كان هذا أمرًا بسيطًا أو مشكلة أكبر ، لذلك أنا متوتر بشأن قيادته بعيدًا.
        
        الاهتزازات: أحصل على اهتزاز طفيف في عجلة القيادة ، خاصةً عندما تكون السيارة خامضة أو إذا كنت أسرع على الطريق السريع. إنها ليست قوية جدًا ، لكنها بالتأكيد ملحوظة ولم تكن موجودة من قبل.
        
        مشكلة الكبح: لقد بدأت أيضًا في الشعور بطحن طفيف عندما أقوم الفرامل ، وخاصة بسرعات أقل. أتساءل عما إذا كان الأمر مرتبطًا أو إذا كانت الفرامل قد تحتاج إلى اهتمام أيضًا.
        
        هل يعاني أي شخص آخر من مشكلات مماثلة؟ أي فكرة عما يمكن أن يسبب هذا؟ وإذا كان أي شخص يعرف ميكانيكي جدير بالثقة في مكان قريب ، فيرجى إبلاغي بذلك! شكرا جزيلا على أي نصيحة! "
        ''',
              style: getLightStyle().copyWith(fontWeight: FontWeight.w700),
            ),
            CustomOfferHelp(
              onTap: () {
                showAlertDialogToMechanic(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
