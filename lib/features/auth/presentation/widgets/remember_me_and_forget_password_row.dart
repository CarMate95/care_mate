import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/text_manager.dart';

class RememberMeAndForgetPasswordRow extends StatefulWidget {
  const RememberMeAndForgetPasswordRow({super.key});

  @override
  State<RememberMeAndForgetPasswordRow> createState() =>
      _RememberMeAndForgetPasswordRowState();
}

class _RememberMeAndForgetPasswordRowState
    extends State<RememberMeAndForgetPasswordRow> {
  bool _isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _isRememberMe = !_isRememberMe;
            });
          },
          icon: Icon(
            _isRememberMe ? Icons.check_circle_outline : Icons.circle_outlined,
            color: Colors.white,
            size: 20.sp,
          ),
        ),
        CustomText(
          text: TextManager.rememberMe,
          style: getMediumStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: CustomText(
            text: TextManager.forgetPassword,
            style: getMediumStyle(
              fontSize: 12,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}