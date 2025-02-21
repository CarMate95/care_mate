import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/helpers/cache_helper.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/routes/page_name.dart';
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
        // remember me checkbox
        IconButton(
          onPressed: () async{
            setState(() {
              _isRememberMe = !_isRememberMe;
            });
            ConstantsManager.rememberMe = await CacheHelper.set(key: 'rememberMe', value: _isRememberMe);
          },
          icon: Icon(
            _isRememberMe ? Icons.check_circle_outline : Icons.circle_outlined,
            color: context.secondaryColor,
            size: 20.sp,
          ),
        ),
        CustomText(
          text: TextManager.rememberMe,
          style: getMediumStyle(
            fontSize: 12,
            color: context.secondaryColor,
          ),
        ),
        const Spacer(),
        // forget password
        InkWell(
          onTap: () {
            // navigate to reset password screen
            Navigator.pushNamed(context, PageName.resetPasswordScreen);
          },
          child: CustomText(
            text: TextManager.forgetPassword,
            style: getMediumStyle(
              fontSize: 12,
              color: context.secondaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
