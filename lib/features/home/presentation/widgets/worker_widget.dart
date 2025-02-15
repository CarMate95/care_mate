import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerWidget extends StatelessWidget {
  const WorkerWidget({super.key, required this.workerImage});
  
  final Widget workerImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 72.w,
      decoration: BoxDecoration(
        color: Colors.grey[300], 
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: FittedBox(
          fit: BoxFit.cover, 
          child: workerImage,
        ),
      ),
    );
  }
}
