import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_no_offers_sessions_view.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_session_appbar.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_session_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionScreenBody extends StatelessWidget {
  const SessionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomSessionAppbar(),
              verticalSpace(32),
              BlocBuilder<GetOffersCubit, GetOffersStates>(
                builder: (context, state) {
                  if (state is GetSessionsSuccessState) {
                    if (state.sessionsList.isEmpty) {
                      return CustomNoDataYet(
                        title: TextManager.noActiveSessionYet.tr(),
                        description: TextManager.descriptionSessionScreen.tr(),
                        imageUrl: AssetsManager.noSessionsBg,
                      );
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => verticalSpace(10),
                      itemBuilder: (context, index) => CustomSessionItem(
                        sessionModel: state.sessionsList[index],
                      ),
                      itemCount: state.sessionsList.length,
                    );
                  } else if (state is GetSessionsLoadingState) {
                    return Center(
                      heightFactor: 15.h,
                      child: const CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    );
                  }
                  return Center(
                    heightFactor: 15.h,
                    child: CustomText(
                      text: 'NO INTERNET CONNECTION , TRY Later',
                      style: getMediumStyle(color: context.secondaryColor),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
