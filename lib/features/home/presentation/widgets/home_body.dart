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
import 'package:car_mate/features/repair/data/repo/request_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 16.h),
        Row(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, PageName.accountdetailsScreen),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: Image.asset(
                    "assets/images/profile_image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, PageName.accountdetailsScreen),
                  child: Text(
                    TextManager.rawanAyman.tr(),
                    style: getBoldStyle(fontSize: 16.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                verticalSpace(2.sp),
                Text(
                  TextManager.welcomeBack.tr(),
                  style: getBoldStyle(fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                _iconButton(
                  context,
                  icon: SvgPicture.asset(AssetsManager.notificationIcon),
                  onTap: () => Navigator.pushNamed(
                    context,
                    PageName.notificationScreen,
                  ),
                ),
                horizontalSpace(8.sp),
                _iconButton(
                  context,
                  icon: Image.asset(AssetsManager.settingPicturePng),
                  onTap: () =>
                      Navigator.pushNamed(context, PageName.settingsScreen),
                ),
              ],
            ),
          ],
        ),
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
            Expanded(
                child: InkWell(
                    onTap: () {
                      OfferRepository().getOffersForPost(2);
                    },
                    child: const UseAIWidget())),
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

Widget _iconButton(BuildContext context,
    {required Widget icon, required VoidCallback onTap}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.r),
    child: Container(
      height: 40.h,
      width: 40.w,
      color: ColorManager.lightGrey,
      child: GestureDetector(
        onTap: onTap,
        child: icon,
      ),
    ),
  );
}
