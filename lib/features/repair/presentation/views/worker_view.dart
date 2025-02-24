// import 'package:car_mate/core/utils/extensions/theme_extension.dart';
// import 'package:car_mate/features/repair/presentation/manager/cubit/get_winch_and_worker_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:car_mate/config/themes/color_manager.dart';
// import 'package:car_mate/config/themes/text_style.dart';
// import 'package:car_mate/core/utils/widgets/custom_text.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class WorkerView extends StatelessWidget {
//   const WorkerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context).size;
//     return BlocBuilder<GetWinchAndWorkerCubit, GetWinchAndWorkerState>(
//       builder: (context, state) {
//         if (state is GetWorkerSuccessfullyState) {
//           if (state.workersList.isEmpty) {
//             return Center(
//               child: CustomText(
//                 text: "No Worker available",
//                 style: getMediumStyle(color: context.secondaryColor),
//               ),
//             );
//           }
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: state.workersList.length,
//             itemBuilder: (context, index) {
//               final worker = state.workersList[index].user;
//               final profilePhoto = (worker.profilePhoto.isNotEmpty)
//                   ? worker.profilePhoto.first
//                   : 'assets/svg/default_image.jpg';

//               return Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Container(
//                     width: mediaQuery.width * 0.4,
//                     height: mediaQuery.height * 0.21,
//                     decoration: BoxDecoration(
//                       border:
//                           Border.all(width: 2, color: ColorManager.lightGrey),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: profilePhoto.startsWith('http')
//                             ? NetworkImage(profilePhoto)
//                             : AssetImage(profilePhoto) as ImageProvider,
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(6),
//                     color: Colors.black.withOpacity(0.5),
//                     child: CustomText(
//                       text: '${worker.firstName} ${worker.lastName}',
//                       style: getMediumStyle(fontSize: 14, color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         } else if (state is GetWorkerFailureState) {
//           return Center(
//             child: Text(
//               state.errorMessage,
//               style: getMediumStyle(
//                   fontSize: 16, color: ColorManager.primaryColor),
//               textAlign: TextAlign.center,
//             ),
//           );
//         }

//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }

import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_winch_and_worker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_mate/config/routes/page_name.dart';

class WorkerView extends StatelessWidget {
  const WorkerView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<GetWinchAndWorkerCubit, GetWinchAndWorkerState>(
      builder: (context, state) {
        if (state is GetWorkerSuccessfullyState) {
          if (state.workersList.isEmpty) {
            return Center(
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
            itemCount: state.workersList.length,
            itemBuilder: (context, index) {
              final worker = state.workersList[index]; // WorkerModel
              final profilePhoto = (worker.user.profilePhoto.isNotEmpty)
                  ? worker.user.profilePhoto.first
                  : 'assets/svg/default_image.jpg';

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
                        border:
                            Border.all(width: 2, color: ColorManager.lightGrey),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profilePhoto.startsWith('http')
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
                            '${worker.user.firstName} ${worker.user.lastName}',
                        style:
                            getMediumStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is GetWorkerFailureState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: getMediumStyle(
                  fontSize: 16, color: ColorManager.primaryColor),
              textAlign: TextAlign.center,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
