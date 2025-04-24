import 'dart:ui';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_build_confirmation_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/session_model.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomSessionItem extends StatelessWidget {
  const CustomSessionItem({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.ArMessages());

    return GestureDetector(
      onTap: () {
        showCustomAlertDialog(
          context: context,
          title: TextManager.problemDetails.tr(),
          content: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 100.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.tertiaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomCircularAvatar(
                        image: sessionModel.user.profilePhoto!.first,
                        backgroundColor: ColorManager.lightPrimaryColor,
                      ),
                      horizontalSpace(8),
                      SizedBox(
                        width: 120.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text:
                                  '${sessionModel.worker.user.firstName}${sessionModel.worker.user.lastName}',
                              style: getMediumStyle(
                                color: context.secondaryColor,
                              ),
                            ),
                            CustomText(
                              lines: 1,
                              text: sessionModel.user.email,
                              style: getMediumStyle(
                                color: context.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  CustomDivider(color: context.secondaryColor),
                  verticalSpace(9),
                  CustomText(
                    text: '${TextManager.yourProblem.tr()}:',
                    style: getMediumStyle(
                      color: context.secondaryColor,
                    ),
                  ),
                  verticalSpace(5),
                  CustomText(
                    text: sessionModel.post.postContent,
                    style: getRegularStyle(
                        fontSize: 12.sp, color: context.secondaryColor),
                  ),
                  verticalSpace(5),
                  sessionModel.endDate == null
                      ? CustomElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: context.scaffoldBackgroundColor,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: customBuildConfirmationDialog(
                                    context: context,
                                    btnText: TextManager.endSession.tr(),
                                    description: TextManager
                                        .areYouSurethatyouwanttoEndthisSession
                                        .tr(),
                                    onPressed: () async {
                                      final result = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: CustomText(
                                              text: TextManager.issYourWorkDone
                                                  .tr()),
                                          content: CustomText(
                                              text: TextManager
                                                  .doYouWantToMarkThisSessionAsDone
                                                  .tr()),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context,
                                                  false), // "No" pressed
                                              child: CustomText(
                                                  text: TextManager.no.tr()),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context,
                                                  true), // "Yes" pressed
                                              child: CustomText(
                                                  text: TextManager.yes.tr()),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (result != null) {
                                        // If result is not null, handle it
                                        if (result == true) {
                                          // "Yes" was pressed
                                          if (!context.mounted) return;

                                          await BlocProvider.of<GetOffersCubit>(
                                                  context)
                                              .endSession(
                                            sessionId: sessionModel.id,
                                            isDone: true,
                                            endDate: DateTime.now()
                                                .toUtc()
                                                .toIso8601String(),
                                          );

                                          if (!context.mounted) return;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: CustomText(
                                                  text: TextManager
                                                      .theSessionWasClosedSuccessFully
                                                      .tr()),
                                              backgroundColor: Colors.green,
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );

                                          Navigator.pushReplacementNamed(
                                            context,
                                            PageName.layoutScreen,
                                          );
                                        } else {
                                          // "No" was pressed
                                          if (!context.mounted) return;

                                          await BlocProvider.of<GetOffersCubit>(
                                                  context)
                                              .endSession(
                                            sessionId: sessionModel.id,
                                            isDone:
                                                false, // Set isDone to false for "No"
                                            endDate: DateTime.now()
                                                .toUtc()
                                                .toIso8601String(),
                                          );

                                          if (!context.mounted) return;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: CustomText(
                                                text: TextManager
                                                    .theSessionClosedButoperationNotActivated
                                                    .tr(),
                                              ),
                                              backgroundColor: Colors.orange,
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );

                                          Navigator.pushReplacementNamed(
                                            context,
                                            PageName.layoutScreen,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          text: State is EndSessionLoadingState
                              ? TextManager.loadingSession.tr()
                              : TextManager.endSession.tr(),
                        )
                      : Center(
                          child: CustomText(
                            style:
                                getMediumStyle(color: context.secondaryColor),
                            text: sessionModel.endDate == null
                                ? TextManager.noEndAlreadyNow.tr()
                                : timeago.format(
                                    DateTime.parse(sessionModel.endDate!),
                                    locale: 'ar'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.tertiaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomCircularAvatar(
                    image: sessionModel.user.profilePhoto!.first,
                    backgroundColor: ColorManager.lightPrimaryColor,
                  ),
                  horizontalSpace(8),
                  SizedBox(
                    width: 145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              '${sessionModel.worker.user.firstName}${sessionModel.worker.user.lastName}',
                          style: getMediumStyle(
                            color: context.secondaryColor,
                          ),
                        ),
                        CustomText(
                          lines: 1,
                          text: sessionModel.worker.user.email,
                          style: getMediumStyle(
                            color: context.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(16),
              CustomDivider(color: context.secondaryColor),
              verticalSpace(9),
              CustomText(
                text: TextManager.yourProblem.tr(),
                style: getMediumStyle(
                  color: context.secondaryColor,
                ),
              ),
              verticalSpace(5),
              CustomText(
                lines: 7,
                text: sessionModel.post.postContent,
                style: getRegularStyle(
                  fontSize: 12,
                ),
              ),
              verticalSpace(10),
              sessionModel.isDone == false
                  ? CustomElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: context.scaffoldBackgroundColor,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: customBuildConfirmationDialog(
                                context: context,
                                btnText: TextManager.endSession.tr(),
                                description: TextManager
                                    .areYouSurethatyouwanttoEndthisSession
                                    .tr(),
                                onPressed: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: CustomText(
                                          text:
                                              TextManager.issYourWorkDone.tr()),
                                      content: CustomText(
                                          text: TextManager
                                              .doYouWantToMarkThisSessionAsDone
                                              .tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, false), // "No" pressed
                                          child: CustomText(
                                              text: TextManager.no.tr()),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, true), // "Yes" pressed
                                          child: CustomText(
                                              text: TextManager.yes.tr()),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (result != null) {
                                    // If result is not null, handle it
                                    if (result == true) {
                                      // "Yes" was pressed
                                      if (!context.mounted) return;

                                      await BlocProvider.of<GetOffersCubit>(
                                              context)
                                          .endSession(
                                        sessionId: sessionModel.id,
                                        isDone: true,
                                        endDate: DateTime.now()
                                            .toUtc()
                                            .toIso8601String(),
                                      );

                                      if (!context.mounted) return;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: CustomText(
                                              text: TextManager
                                                  .theSessionWasClosedSuccessFully
                                                  .tr()),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      Navigator.pushReplacementNamed(
                                        context,
                                        PageName.layoutScreen,
                                      );
                                    } else {
                                      // "No" was pressed
                                      if (!context.mounted) return;

                                      await BlocProvider.of<GetOffersCubit>(
                                              context)
                                          .endSession(
                                        sessionId: sessionModel.id,
                                        isDone:
                                            false, // Set isDone to false for "No"
                                        endDate: DateTime.now()
                                            .toUtc()
                                            .toIso8601String(),
                                      );

                                      if (!context.mounted) return;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: CustomText(
                                            text: TextManager
                                                .theSessionClosedButoperationNotActivated
                                                .tr(),
                                          ),
                                          backgroundColor: Colors.orange,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      Navigator.pushReplacementNamed(
                                        context,
                                        PageName.layoutScreen,
                                      );
                                    }
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                      text: TextManager.endSession.tr(),
                    )
                  : Center(
                      child: CustomText(
                        style: getMediumStyle(color: context.secondaryColor),
                        text: sessionModel.endDate == null
                            ? TextManager.noEndAlreadyNow.tr()
                            : timeago.format(
                                DateTime.parse(sessionModel.endDate!),
                                locale: 'ar'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
