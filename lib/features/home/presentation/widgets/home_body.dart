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

import 'home_app_bar.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 16.h),
        // home app bar
         const HomeAppBar(),
        SizedBox(height: 16.h),
        const ProblemWidget(),
        verticalSpace(3.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageName.addnotepage);
                },
                child: HomeActions(
                  isIcon: true,
                  text: TextManager.setReminder.tr(),
                ),
              ),
            ),
            horizontalSpace(3.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageName.winchAndWorkerScreen);
                },
                child: HomeActions(
                  isIcon: false,
                  text: TextManager.viewWorkers.tr(),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(12.sp),
        Row(
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
                size: 20.sp,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              ),
            ),
          ],
        ),
        verticalSpace(8.sp),
        SizedBox(
          height: 50.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              AlertHomeWidget(
                image: AssetsManager.brakeWarning,
                title: TextManager.brakeWarning.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                image: AssetsManager.engineCheckImage,
                title: TextManager.checkEngine.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                image: AssetsManager.temperatureImage,
                title: TextManager.temperatureWarning.tr(),
              ),
              horizontalSpace(6.sp),
              AlertHomeWidget(
                image: AssetsManager.tirePressure,
                title: TextManager.tirePressure.tr(),
              ),
            ],
          ),
        ),
        verticalSpace(12.sp),
        Row(
          children: [
            const Expanded(child: UseAIWidget()),
            horizontalSpace(8.sp),
            const Expanded(child: ReminderWidget()),
          ],
        ),
        verticalSpace(12.sp),
        Row(
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
                size: 20.sp,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              ),
            ),
          ],
        ),
        verticalSpace(8.sp),
        SizedBox(
          height: 80.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
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
