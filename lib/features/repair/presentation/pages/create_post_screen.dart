import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_floating_action_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController problemController = TextEditingController();
  bool isTextEntered = false;

  @override
  void initState() {
    super.initState();
    problemController.addListener(() {
      setState(() {
        isTextEntered = problemController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: ColorManager.darkGrey,
        title: Text(
          TextManager.requests.tr(),
          style: getBoldStyle(color: ColorManager.lightGrey),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: ColorManager.lightGrey,
              size: 30,
            )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {},
        icon: Icons.photo_library_rounded,
        backgroundColor: ColorManager.darkGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: ListView(
          children: [
            Row(
              children: [
                const CustomCircularAvatar(),
                horizontalSpace(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'عبد الرحمن فوزي',
                      style: getMediumStyle(color: context.secondaryColor)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    CustomText(
                      text: '@FawWwWwzy',
                      style: getLightStyle(
                              color: context.isDarkMode
                                  ? ColorManager.lightGrey
                                  : ColorManager.black)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: isTextEntered
                          ? ColorManager.lightGrey
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorManager.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 5.0.h),
                      child: CustomText(
                        text: TextManager.post,
                        style: getMediumStyle(
                            color: isTextEntered
                                ? ColorManager.black
                                : ColorManager.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomDivider(),
            TextField(
              controller: problemController,
              maxLines: null,
              cursorColor:
                  context.isDarkMode ? ColorManager.grey : ColorManager.black,
              style: getLightStyle(
                  color: context.isDarkMode
                      ? ColorManager.white
                      : ColorManager.black),
              decoration: InputDecoration(
                labelStyle: getMediumStyle(),
                hintText: TextManager.whatHappening.tr(),
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
