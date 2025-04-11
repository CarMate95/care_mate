import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomOfferWidget extends StatelessWidget {
  const CustomOfferWidget({super.key, required this.offerModel});
  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    final user = offerModel.worker?.user;
    final timeAgoText = timeago.format(offerModel.createdAt, locale: 'ar');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.tertiaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: (user?.profilePhoto != null &&
                            user!.profilePhoto!.isNotEmpty)
                        ? NetworkImage(user.profilePhoto!.first)
                        : const AssetImage('assets/png/worker_2.png')
                            as ImageProvider,
                  ),
                  horizontalSpace(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text:
                                '${user?.firstName ?? 'No'} ${user?.lastName ?? 'Name'}',
                            style: getMediumStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          horizontalSpace(4),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xff00AAFF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          horizontalSpace(4),
                          CustomText(
                            text: timeAgoText,
                            style: getMediumStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                      CustomText(
                        text: user?.email ?? 'mohamed@gmail.com',
                        style: getLightStyle(),
                      ),
                    ],
                  )
                ],
              ),
              verticalSpace(8),
              CustomText(
                style: getLightStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
                text: offerModel.note,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
