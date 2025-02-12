import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class WorkerView extends StatelessWidget {
  const WorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: mediaQuery.width * 0.4,
            height: mediaQuery.height * 0.21,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: ColorManager.lightGrey),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/svg/gmail_icon_svg.jpg')),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const CustomText(text: 'Mohamed Ezzat')
        ],
      ),
      itemCount: 20,
    );
  }
}
