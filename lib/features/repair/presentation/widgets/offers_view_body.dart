import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:car_mate/features/repair/presentation/widgets/customAlertDialog.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_no_offers_sessions_view.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_offer_widget.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_offers_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersViewBody extends StatefulWidget {
  const OffersViewBody({super.key, required this.postId});
  final int postId;

  @override
  State<OffersViewBody> createState() => _OffersViewBodyState();
}

class _OffersViewBodyState extends State<OffersViewBody> {
  @override
  void initState() {
    super.initState();
    // Fetch the offers when the widget is initialized
    BlocProvider.of<GetOffersCubit>(context).fetchOffers(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomOffersAppBar(),
            verticalSpace(32),
            BlocBuilder<GetOffersCubit, GetOffersStates>(
              builder: (context, state) {
                if (state is GetOffersSuccessState) {
                  if (state.offers.isEmpty) {
                    // No offers available, display a custom no data view
                    return CustomNoDataYet(
                      title: TextManager.noOffersYet.tr(),
                      description: TextManager
                          .whenyoureceiveanofferfromaworkeryoullseeithere
                          .tr(),
                      imageUrl: AssetsManager.noOffersBg,
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.offers.length,
                    itemBuilder: (context, index) {
                      final offer = state.offers[index];
                      return InkWell(
                        onTap: () {
                          showAlertDialogToUser(context, offer);
                        },
                        child: CustomOfferWidget(
                          offerModel: offer,
                        ),
                      );
                    },
                  );
                } else if (state is GetOffersLoadingState) {
                  // Show a loading indicator while fetching offers
                  return Center(
                    heightFactor: 15.h,
                    child: const CircularProgressIndicator(
                      color: Colors.blueGrey,
                    ),
                  );
                } else if (state is GetOffersFailerState) {
                  // Show error message if the offer fetching fails
                  return Center(
                    child: Text(
                      state.errorMessage ??
                          'Failed to load offers. Try again later.',
                      style: getLightStyle(color: Colors.red),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    'An unexpected error occurred. Please try again.',
                    style: getLightStyle(color: Colors.amber),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
