import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/home/presentation/widgets/alert_home_widget.dart';
import 'package:car_mate/features/home/presentation/widgets/home_actions.dart';
import 'package:car_mate/features/home/presentation/widgets/problem_widget.dart';
import 'package:car_mate/features/home/presentation/widgets/reminder_widget.dart';
import 'package:car_mate/features/home/presentation/widgets/use_ai_widget.dart';
import 'package:car_mate/features/home/presentation/widgets/worker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero, 
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: const ProblemWidget(),
        ),
        verticalSpace(12.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Row(
            children: [
              Expanded(
                child: HomeActions(
                  isIcon: true,
                  text: TextManager.setReminder.tr(),
                ),
              ),
              horizontalSpace(8.sp),
              Expanded(
                child: HomeActions(
                  isIcon: false,
                  text: TextManager.viewWorkers.tr(),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(12.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextManager.signAndAlerts.tr(),
                style: getBoldStyle(fontSize: 16.sp),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageName.alertsScreen);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: context.isDarkMode ? ColorManager.white : ColorManager.black,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(8.sp),
        SizedBox(
          height: 85.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            children: [
              AlertHomeWidget(
                imageWidget: Image.asset(AssetsManager.brakeWarning, width: 38.w),
                title: TextManager.brakeWarning.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                imageWidget: Image.asset(AssetsManager.engineCheckImage, width: 38.w),
                title: TextManager.checkEngine.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                imageWidget: Image.asset(AssetsManager.temperatureImage, width: 38.w),
                title: TextManager.temperatureWarning.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                imageWidget: Image.asset(AssetsManager.tirePressure, width: 38.w),
                title: TextManager.tirePressure.tr(),
              ),
            ],
          ),
        ),
        verticalSpace(12.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Row(
            children: [
              Expanded(child: const UseAIWidget()),
              horizontalSpace(8.sp),
              Expanded(child: const ReminderWidget()),
            ],
          ),
        ),
        verticalSpace(12.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TextManager.mechanicCanHelp.tr(),
                style: getBoldStyle(fontSize: 16.sp),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageName.winchAndWorkerScreen);
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: context.isDarkMode ? ColorManager.white : ColorManager.black,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(8.sp),
        SizedBox(
          height: 90.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            children: [
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker1)),
              horizontalSpace(6.sp),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker2)),
              horizontalSpace(6.sp),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker3)),
              horizontalSpace(6.sp),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker4)),
            ],
          ),
        ),
      ],
    );
  }
}
