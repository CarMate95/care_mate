import 'dart:developer';
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
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      text: '${TextManager.yourProblem}:',
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
                                backgroundColor:
                                    context.scaffoldBackgroundColor,
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
                                        if (context.mounted) {
                                          await BlocProvider.of<GetOffersCubit>(
                                                  context)
                                              .endSession(
                                            sessionId: sessionModel.id,
                                            endDate: DateTime.now()
                                                .toUtc()
                                                .toIso8601String(),
                                          );
                                          log('End Session Request Sent');
                                          BlocProvider.of<GetOffersCubit>(
                                                  context)
                                              .fetchSessions();

                                          Navigator.pushReplacementNamed(
                                              context, PageName.getOfferScreen,
                                              arguments: sessionModel.postId);
                                        }
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            text: State is EndSessionLoadingState
                                ? TextManager.loadingSession.tr()
                                : TextManager.endSession.tr())
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
            ));
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
                                  await BlocProvider.of<GetOffersCubit>(context)
                                      .endSession(
                                    sessionId: sessionModel.id,
                                    endDate: DateTime.now()
                                        .toUtc()
                                        .toIso8601String(),
                                  );
                                  log('End Session Successfully');

                                  Navigator.pushReplacementNamed(
                                      context, PageName.getOfferScreen,
                                      arguments: sessionModel.postId);
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
