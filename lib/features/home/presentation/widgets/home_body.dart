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
      children: [
        verticalSpace(30.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: const ProblemWidget(),
        ),
        verticalSpace(2.h),
        Row(children: [
          horizontalSpace(6.w),
          HomeActions(
            isIcon: true,
            text: TextManager.setReminder.tr(),
          ),
          horizontalSpace(3.w),
          HomeActions(
            isIcon: false,
            text: TextManager.viewWorkers.tr(),
          ),
          horizontalSpace(4.w),
        ]),
        verticalSpace(10.sp),
        Padding(
          padding: EdgeInsets.all(20.sp),
          child: Container(
            child: Row(
              children: [
                Text(
                  TextManager.signAndAlerts.tr(),
                  style: getBoldStyle(fontSize: 16.sp),
                ),
                context.deviceLocale.languageCode == 'en_US'
                    ? horizontalSpace(180.w)
                    : horizontalSpace(140.w),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageName.alertsScreen);
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    )),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 50.h,
          width: double.infinity,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            AlertHomeWidget(
              imageWidget: Image.asset(AssetsManager.brakeWarning),
              title: TextManager.brakeWarning.tr(),
            ),
            AlertHomeWidget(
              imageWidget: Image.asset(AssetsManager.engineCheckImage),
              title: TextManager.checkEngine.tr(),
            ),
            AlertHomeWidget(
              imageWidget: Image.asset(AssetsManager.temperatureImage),
              title: TextManager.temperatureWarning.tr(),
            ),
            AlertHomeWidget(
              imageWidget: Image.asset(AssetsManager.tirePressure),
              title: TextManager.tirePressure.tr(),
            ),
          ]),
        ),
        verticalSpace(20.sp),
        Row(children: [
          horizontalSpace(10.sp),
          const UseAIWidget(),
          horizontalSpace(10.sp),
          const ReminderWidget(),
        ]),
        verticalSpace(10.sp),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                TextManager.mechanicCanHelp.tr(),
                style: getBoldStyle(fontSize: 16.sp),
              ),
              context.deviceLocale.languageCode == 'en_US'
                  ? horizontalSpace(150.w)
                  : horizontalSpace(80.w),
              Icon(
                Icons.arrow_forward_ios,
                color: context.isDarkMode
                    ? ColorManager.white
                    : ColorManager.black,
              )
            ],
          ),
        ),
        Container(
            height: 50.h,
            width: double.infinity,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker1)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker2)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker3)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker4)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker1)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker2)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker3)),
              WorkerWidget(workerImage: Image.asset(AssetsManager.worker4))
            ]))
      ],
    );
  }
}
