import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerView extends StatelessWidget {
  const WorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<GetOffersCubit, GetOffersStates>(
      builder: (context, state) {
        if (state is GetOffersSuccessState) {
          if (state.offers.isEmpty) {
            return Center(
              heightFactor: 17.h,
              child: CustomText(
                text: "No Worker available",
                style: getMediumStyle(color: context.secondaryColor),
              ),
            );
          }
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.offers.length,
              itemBuilder: (context, index) {
                final worker = state.offers[index];

                final profilePhoto =
                    (worker.worker?.user.profilePhoto.isNotEmpty ?? false)
                        ? worker.worker!.user.profilePhoto.first
                        : 'assets/png/worker_1.png';

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PageName.workerDetailsScreen,
                      arguments: worker, // Pass the worker data
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: mediaQuery.width * 0.4,
                        height: mediaQuery.height * 0.21,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: ColorManager.lightGrey),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: profilePhoto.startsWith('https')
                                ? NetworkImage(profilePhoto)
                                : AssetImage(profilePhoto) as ImageProvider,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        color: Colors.black.withOpacity(0.5),
                        child: CustomText(
                          text:
                              '${worker.worker?.user.firstName ?? ''} ${worker.worker?.user.lastName ?? ''}',
                          style:
                              getMediumStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              });
        } else if (state is GetOffersFailerState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: getMediumStyle(
                  fontSize: 16, color: ColorManager.primaryColor),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Center(
            heightFactor: 15.h, child: const CircularProgressIndicator());
      },
    );
  }
}
