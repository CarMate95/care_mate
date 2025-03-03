import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/text_style.dart';

showScaffoldMessage(BuildContext context, {String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      elevation: 0,
      content: Container(
        margin: EdgeInsets.only(bottom: 80.r),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                message ?? "Will comming soon",
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
