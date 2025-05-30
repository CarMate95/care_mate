import 'dart:developer';

import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

void showAlertDialogToUser(
  BuildContext context,
  OfferModel offerModel,
) {
  var mediaQuery = MediaQuery.of(context).size;
  final user = offerModel.worker?.user;
  final session = offerModel.session;

  showCustomAlertDialog(
    context: context,
    title: TextManager.requests,
    content: BlocConsumer<GetOffersCubit, GetOffersStates>(
      listener: (context, state) async {
        timeago.setLocaleMessages('en', timeago.ArMessages());
        if (state is StartSessionSuccessState) {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pushNamed(context, PageName.sessionScreen);
            log('Started Successfully !!!!!!!!!!!');
          }
        } else if (state is StartSessionFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
          log(state.errorMessage);
        }
      },
      builder: (context, state) => Column(
        children: [
          Text(
            '${TextManager.by.tr()} : ${user?.firstName ?? 'No'} ${user?.lastName ?? 'Name'}',
            style: getLightStyle(),
          ),
          verticalSpace(10),
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: context.tertiaryColor,
                        ),
                      ),
                      child: Text(
                        offerModel.note,
                        style: getLightStyle(),
                      ),
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PageName.workerDetailsScreen,
                              arguments: offerModel,
                            );
                          },
                          child: Container(
                            width: mediaQuery.width * 0.43,
                            height: mediaQuery.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorManager.primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomText(
                                  text: TextManager.workerDetails,
                                  style: getMediumStyle(
                                    color: ColorManager.whiteBackground,
                                  ),
                                ),
                                const Icon(
                                  Icons.person,
                                  color: ColorManager.whiteBackground,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: mediaQuery.width * 0.43,
                              height: mediaQuery.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: context.tertiaryColor,
                                ),
                                color: ColorManager.transparent,
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: getLightStyle(fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: offerModel.cash.toString(),
                                        style: getMediumStyle(
                                          color: context.secondaryColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " \$",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -13,
                              left: 20,
                              child: Text(
                                TextManager.cash.tr(),
                                style: getMediumStyle(
                                  color: context.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    session == null
                        ? offerModel.isAccepted == true
                            ? const SizedBox()
                            : InkWell(
                                onTap: () async {
                                  if (context.mounted) {
                                    final cubit =
                                        BlocProvider.of<GetOffersCubit>(
                                            context);

                                    await cubit.startSession(
                                      postId: offerModel.postId,
                                      offerId: offerModel.id,
                                      startDate: DateTime.now()
                                          .toUtc()
                                          .toIso8601String(),
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48.h,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: state is StartSessionLoadingState
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${TextManager.loading.tr()}...',
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : Center(
                                          child: CustomText(
                                            text: 'Start Work Together',
                                            style: getRegularStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                ),
                              )
                        : session.endDate == null
                            ? CustomText(
                                text: 'In Progress',
                                style: getMediumStyle(color: Colors.red),
                              )
                            : Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      style: getMediumStyle(
                                          color: context.secondaryColor),
                                      text: timeago.format(
                                        session.endDate!,
                                        locale: 'ar',
                                      ),
                                    ),
                                    const CustomText(text: 'Is Done'),
                                  ],
                                ),
                              ),
                  ],
                ),
                Positioned(
                  top: -13,
                  left: 20,
                  child: Text(
                    TextManager.note.tr(),
                    style: getMediumStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
