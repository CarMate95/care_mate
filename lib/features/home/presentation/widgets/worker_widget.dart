
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerWidget extends StatelessWidget {
  const WorkerWidget({super.key, required this.workerImage});
final Widget workerImage;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 72.h,
        width: 72.w,
        child: workerImage,
      ),
    );
  }
}
