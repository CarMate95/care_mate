import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_winch_and_worker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinchView extends StatelessWidget {
  const WinchView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<GetWinchAndWorkerCubit, GetWinchAndWorkerState>(
      builder: (context, state) {
        if (state is GetWinchSuccessfullyState) {
          if (state.winchsList.isEmpty) {
            return Center(
              child: CustomText(
                text: "No winches available",
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
            itemCount: state.winchsList.length,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: mediaQuery.width * 0.4,
                    height: mediaQuery.height * 0.21,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: ColorManager.lightGrey),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: state.winchsList[index].profilePhoto.isNotEmpty
                            ? NetworkImage(state.winchsList[index].profilePhoto)
                            : const AssetImage('assets/svg/gmail_icon_svg.jpg')
                                as ImageProvider,
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
                          '${state.winchsList[index].firstName} ${state.winchsList[index].lastName}',
                      style: getMediumStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          );
        } else if (state is GetWinchFailureState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: getMediumStyle(
                  fontSize: 16, color: ColorManager.primaryColor),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
